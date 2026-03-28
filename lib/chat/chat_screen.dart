import 'package:chatapp/home/model/messages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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

    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent + 100,
        duration: Duration(milliseconds: 300),
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
    return Scaffold(
      appBar: AppBar(title: Text(widget.otherUserName)),
      body: Column(
        children: [
          StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection("chats")
                .doc(widget.chatId)
                .snapshots(),
            builder: (context, snapShot) {
              if (snapShot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapShot.hasError) {
                print(snapShot.error.toString());
                return Center(child: Text(snapShot.error.toString()));
              }
              if (snapShot.hasData || snapShot.data!.exists) {
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

                return Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: messages.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final msg = messages[index];
                      final isMe = msg.senderId == currentUserId;
                      return Align(
                        alignment: isMe
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 10,
                          ),
                          decoration: BoxDecoration(
                            color: isMe ? Colors.green : Colors.blue,
                            borderRadius: isMe
                                ? BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                    bottomLeft: Radius.circular(15),
                                  )
                                : BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                    bottomRight: Radius.circular(15),
                                  ),
                          ),
                          child: Text(
                            msg.text ?? "",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else {
                return SizedBox.shrink();
              }
            },
          ),

          Row(
            children: [
              Container(margin: EdgeInsets.symmetric(horizontal: 10)),
              Expanded(
                child: TextFormField(
                  controller: _messageController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    hintText: "Type a message",
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send, color: Colors.green, size: 30),
                onPressed: () {
                  sendMessage();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
