import 'dart:developer';

import 'package:chatapp/core/services/seend_messeging.dart';
import 'package:chatapp/home/model/messages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../core/theme/theme_extension.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    super.key,
    required this.chatId,
    required this.otherUserName,
  });
  final String chatId;
  final String otherUserName;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void sendMessage() async {
    final text = _messageController.text;
    if (text.isEmpty) return;
    _messageController.clear();

    final curentUserId = FirebaseAuth.instance.currentUser!.uid;

    final newMessage = {
      "senderId": curentUserId,
      "text": text,
      "time": DateTime.now().toIso8601String(),
    };
    await FirebaseFirestore.instance
        .collection("chats")
        .doc(widget.chatId)
        .update({
          "messages": FieldValue.arrayUnion([newMessage]),
        });
    final chat = await FirebaseFirestore.instance
        .collection("chats")
        .doc(widget.chatId)
        .get();

    final currentUser = FirebaseAuth.instance.currentUser!.uid;
    String otherUserId = chat['users'][0] == currentUser
        ? chat['users'][1]
        : chat['users'][0];
    print("otherUserId: $otherUserId");
    final fcmToken = await FirebaseFirestore.instance
        .collection("user")
        .doc(otherUserId)
        .get();
    await sendNotification(
      chatId: widget.chatId,
      message: text,
      fcmToken: fcmToken['fcmToken'],
      senderId: curentUserId,
    );

    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent + 100,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;
    final colors = context.colors;
    final textStyles = context.textStyles;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.surface.withValues(alpha: 0.95),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: colors.primaryGradient,
              ),
              child: CircleAvatar(
                radius: 18,
                backgroundColor: colors.surface,
                child: Icon(Icons.person, color: colors.primary, size: 20),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.otherUserName,
                    style: textStyles.textButtonPrimary.copyWith(
                      color: colors.textPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "Online",
                    style: textStyles.chatTimeText.copyWith(
                      color: colors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.videocam, color: colors.primary),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.call, color: colors.primary),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("chats")
                  .doc(widget.chatId)
                  .snapshots(),
              builder: (context, snapShot) {
                if (snapShot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(color: colors.primary),
                  );
                }
                if (snapShot.hasError) {
                  return Center(
                    child: Text(
                      snapShot.error.toString(),
                      style: textStyles.labelText.copyWith(color: Colors.red),
                    ),
                  );
                }
                if (snapShot.hasData && snapShot.data!.exists) {
                  final data =
                      snapShot.data!.data() as Map<String, dynamic>? ?? {};
                  final rawMessages = data['messages'] as List<dynamic>? ?? [];
                  final messages = rawMessages
                      .map((e) => Messages.fromJson(e as Map<String, dynamic>))
                      .toList();

                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (_scrollController.hasClients) {
                      _scrollController.jumpTo(
                        _scrollController.position.maxScrollExtent,
                      );
                    }
                  });

                  if (messages.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.chat_bubble_outline,
                            size: 60,
                            color: colors.textSecondary.withValues(alpha: 0.3),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            "Say hello! 👋",
                            style: textStyles.headerSecondary,
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final msg = messages[index];
                      final isMe = msg.senderId == currentUserId;
                      return Align(
                        alignment: isMe
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.75,
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 16,
                          ),
                          margin: const EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 12,
                          ),
                          decoration: BoxDecoration(
                            gradient: isMe
                                ? colors.msgGradientMe
                                : LinearGradient(
                                    colors: [colors.surface, colors.surface],
                                  ),
                            borderRadius: isMe
                                ? const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(5),
                                  )
                                : const BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    topRight: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                    bottomLeft: Radius.circular(20),
                                  ),
                            boxShadow: [
                              BoxShadow(
                                color: isMe
                                    ? colors.primary.withValues(alpha: 0.2)
                                    : Colors.black.withValues(alpha: 0.05),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                            border: isMe
                                ? null
                                : Border.all(
                                    color: colors.primaryBorder.withValues(
                                      alpha: 0.3,
                                    ),
                                  ),
                          ),
                          child: Text(
                            msg.text ?? "",
                            style: textStyles.textWhite.copyWith(
                              color: isMe ? Colors.white : colors.textPrimary,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ),

          // Input Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: colors.surface,
              border: Border(
                top: BorderSide(
                  color: colors.primaryBorder.withValues(alpha: 0.3),
                ),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: SafeArea(
              top: false,
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.add_circle_outline, color: colors.primary),
                    onPressed: () {},
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: colors.background,
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          color: colors.primaryBorder.withValues(alpha: 0.4),
                        ),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 16),
                          Expanded(
                            child: TextField(
                              controller: _messageController,
                              style: textStyles.textButtonPrimary.copyWith(
                                color: colors.textPrimary,
                              ),
                              decoration: InputDecoration(
                                hintText: "Type a message...",
                                hintStyle: textStyles.labelText.copyWith(
                                  color: colors.textSecondary.withValues(
                                    alpha: 0.5,
                                  ),
                                ),
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                              ),
                              textInputAction: TextInputAction.send,
                              onSubmitted: (_) => sendMessage(),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.emoji_emotions_outlined,
                              color: colors.textSecondary,
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: sendMessage,
                    child: Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: colors.primaryGradient,
                        boxShadow: [
                          BoxShadow(
                            color: colors.primary.withValues(alpha: 0.4),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
