import 'package:chatapp/home/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:chatapp/chat/view/chat_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String searchQuery = "";

  void _createOrNavigateToChat(UserModel user) async {
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;

    // Check if chat existed
    final chatsQuery = await FirebaseFirestore.instance
        .collection('chats')
        .where('users', arrayContains: currentUserId)
        .get();

    String? existingChatId;

    for (var doc in chatsQuery.docs) {
      final users = List<String>.from(doc['users'] ?? []);
      if (users.contains(user.id)) {
        existingChatId = doc.id;
        break;
      }
    }

    if (!mounted) return;

    if (existingChatId != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ChatScreen(
            chatId: existingChatId!,
            otherUserName: user.name,
            otherUserImage: (user.image == null || user.image!.isEmpty)
                ? "https://cdn-icons-png.flaticon.com/512/149/149071.png"
                : user.image!,
          ),
        ),
      );
    } else {
      // Create new chat
      final newChatRef = FirebaseFirestore.instance.collection('chats').doc();
      await newChatRef.set({
        'users': [currentUserId, user.id],
        'messages': [],
      });

      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ChatScreen(
            chatId: newChatRef.id,
            otherUserName: user.name,
            otherUserImage: (user.image == null || user.image!.isEmpty)
                ? "https://cdn-icons-png.flaticon.com/512/149/149071.png"
                : user.image!,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          autofocus: true,
          onChanged: (val) {
            setState(() {
              searchQuery = val.trim();
            });
          },
          decoration: InputDecoration(
            hintText: "Search for users...",
            border: InputBorder.none,
          ),
        ),
      ),
      body: searchQuery.isEmpty
          ? Center(child: Text("Search by name"))
          : StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('user')
                  .where('name', isGreaterThanOrEqualTo: searchQuery)
                  .where('name', isLessThanOrEqualTo: '$searchQuery\uf8ff')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text("An error occurred"));
                }

                final users =
                    snapshot.data?.docs.map((e) {
                      return UserModel.fromJson(
                        e.data() as Map<String, dynamic>,
                        docId: e.id,
                      );
                    }).toList() ??
                    [];

                // Filter out current user
                final filteredUsers = users
                    .where(
                      (user) =>
                          user.id != FirebaseAuth.instance.currentUser!.uid,
                    )
                    .toList();

                if (filteredUsers.isEmpty) {
                  return Center(child: Text("No users found"));
                }

                return ListView.builder(
                  itemCount: filteredUsers.length,
                  itemBuilder: (context, index) {
                    final user = filteredUsers[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                          (user.image == null || user.image!.isEmpty)
                              ? "https://cdn-icons-png.flaticon.com/512/149/149071.png"
                              : user.image!,
                        ),
                      ),
                      title: Text(user.name),
                      subtitle: Text(user.email),
                      onTap: () => _createOrNavigateToChat(user),
                    );
                  },
                );
              },
            ),
    );
  }
}
