import 'package:chatapp/home/model/chat_item_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:chatapp/chat/view/chat_screen.dart';
import 'package:intl/intl.dart';

class ItemChat extends StatelessWidget {
  const ItemChat({super.key, required this.chatItemModel});
  final ChatItemModel chatItemModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(
              chatId: chatItemModel.id,
              otherUserName: chatItemModel.name ?? "Unknown",
              otherUserImage:
                  (chatItemModel.image == null || chatItemModel.image!.isEmpty)
                  ? "https://cdn-icons-png.flaticon.com/512/149/149071.png"
                  : chatItemModel.image!,
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(5),
        height: 80,
        width: MediaQuery.of(context).size.width / 1,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Color(0xff771F98), width: 2),
        ),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(
              (chatItemModel.image == null || chatItemModel.image!.isEmpty)
                  ? "https://cdn-icons-png.flaticon.com/512/149/149071.png"
                  : chatItemModel.image!,
            ),
          ),
          title: Text(chatItemModel.name.toString()),
          subtitle: Text(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            chatItemModel.message.isNotEmpty
                ? chatItemModel.message.last.text.toString()
                : "No messages yet",
          ),
          trailing: Column(
            children: [
              Text(
                chatItemModel.message.isNotEmpty
                    ? DateFormat('h:mm a').format(
                        DateTime.parse(chatItemModel.message.last.time ?? ""),
                      )
                    : "",
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
