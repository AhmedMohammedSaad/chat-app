import 'package:chatapp/home/model/chat_item_model.dart';
import 'package:chatapp/home/view/widget/item_chat.dart';
import 'package:chatapp/home/view/widget/search_chat.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: SizedBox(height: 50)),
            SliverToBoxAdapter(child: SearchChat()),

            SliverToBoxAdapter(
              child: ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ItemChat(
                    chatItemModel: ChatItemModel(
                      name: "Ahmed",
                      image:
                          "https://cdn-icons-png.flaticon.com/512/149/149071.png",
                      message: "Hello",
                      time: "10:00 AM",
                      unreadCount: '3',
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 10);
                },
                itemCount: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
