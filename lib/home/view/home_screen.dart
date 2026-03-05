import 'package:chatapp/home/cubit/home_cubit.dart';

import 'package:chatapp/home/view/widget/item_chat.dart';
import 'package:chatapp/home/view/widget/search_chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getUserChats(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: SizedBox(height: 50)),
              SliverToBoxAdapter(child: SearchChat()),

              SliverToBoxAdapter(
                child: BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    if (state is GetChatFailure) {
                      return Center(child: Text(state.errorMessage));
                    } else if (state is GetChatLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is GetChatSuccess) {
                      final chats = state.chats;
                      if (chats.isEmpty) {
                        return Center(child: Text("No chats found"));
                      }

                      return ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final chat = chats[index];
                          return ItemChat(chatItemModel: chat);
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 10);
                        },
                        itemCount: chats.length,
                      );
                    } else {
                      return SizedBox.shrink();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
