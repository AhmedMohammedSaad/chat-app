import 'package:chatapp/home/cubit/home_cubit.dart';
import 'package:chatapp/home/view/widget/item_chat.dart';
import 'package:chatapp/home/view/widget/search_chat.dart';
import 'package:chatapp/core/theme/cubit/theme_cubit.dart';
import 'package:chatapp/core/theme/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textStyles = context.textStyles;

    return BlocProvider(
      create: (context) => HomeCubit()..getUserChats(),
      child: Scaffold(
        backgroundColor: colors.background,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Messages",
                          style: textStyles.headerPrimary,
                        ),
                        Row(
                          children: [
                            // Theme toggle button
                            GestureDetector(
                              onTap: () => context.read<ThemeCubit>().toggleTheme(),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: colors.surface,
                                  border: Border.all(color: colors.primaryBorder),
                                  boxShadow: [
                                    BoxShadow(
                                      color: colors.primary.withValues(alpha: 0.2),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Theme.of(context).brightness == Brightness.dark
                                      ? Icons.light_mode_rounded
                                      : Icons.dark_mode_rounded,
                                  color: colors.primary,
                                  size: 22,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: colors.primaryGradient,
                              ),
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: colors.surface,
                                child: Icon(
                                  Icons.person,
                                  color: colors.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: SearchChat()),
                const SliverToBoxAdapter(child: SizedBox(height: 24)),
                SliverToBoxAdapter(
                  child: BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, state) {
                      if (state is GetChatFailure) {
                        return Center(
                          child: Text(
                            state.errorMessage,
                            style: textStyles.labelText.copyWith(color: Colors.red),
                          ),
                        );
                      } else if (state is GetChatLoading) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: colors.primary,
                          ),
                        );
                      } else if (state is GetChatSuccess) {
                        final chats = state.chats;
                        if (chats.isEmpty) {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 40.0),
                              child: Column(
                                children: [
                                  Icon(Icons.chat_bubble_outline,
                                      size: 60,
                                      color: colors.textSecondary.withValues(alpha: 0.3)),
                                  const SizedBox(height: 16),
                                  Text(
                                    "No messages yet",
                                    style: textStyles.headerSecondary,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }

                        return ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(bottom: 20),
                          itemBuilder: (context, index) {
                            final chat = chats[index];
                            return ItemChat(chatItemModel: chat);
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(height: 8);
                          },
                          itemCount: chats.length,
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
