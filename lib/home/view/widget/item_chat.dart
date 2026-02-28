import 'package:chatapp/home/model/chat_item_model.dart';
import 'package:flutter/material.dart';

class ItemChat extends StatelessWidget {
  const ItemChat({super.key, required this.chatItemModel});
  final ChatItemModel chatItemModel;

  @override
  Widget build(BuildContext context) {
    return Container(
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
            chatItemModel.image ??
                "https://cdn-icons-png.flaticon.com/512/149/149071.png",
          ),
        ),
        title: Text(chatItemModel.name ?? "Ahmed"),
        subtitle: Text(
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          chatItemModel.message ?? "hello",
        ),
        trailing: Column(
          children: [
            Text(
              chatItemModel.time ?? "10:00 AM",
              style: TextStyle(fontSize: 12),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xff771F98),
              ),
              child: Text(
                chatItemModel.unreadCount ?? "1",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
