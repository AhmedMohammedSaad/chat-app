import 'package:chatapp/chat/chat_screen.dart';
import 'package:chatapp/home/cubit/cubit_search/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/theme/theme_extension.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textStyles = context.textStyles;

    return BlocProvider(
      create: (context) => SearchCubit(),
      child: Scaffold(
        backgroundColor: colors.background,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: colors.textPrimary),
            onPressed: () => Navigator.pop(context),
          ),
          title: Builder(
            builder: (context) {
              return Container(
                height: 45,
                decoration: BoxDecoration(
                  color: colors.surface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: colors.primaryBorder.withValues(alpha: 0.4)),
                  boxShadow: [
                    BoxShadow(
                      color: colors.primary.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: TextField(
                  controller: controller,
                  style: textStyles.textButtonPrimary.copyWith(color: colors.textPrimary),
                  onSubmitted: (value) {
                    context.read<SearchCubit>().searchUser(controller.text.trim());
                  },
                  decoration: InputDecoration(
                    hintText: 'Search users...',
                    hintStyle: textStyles.labelText.copyWith(
                      color: colors.textSecondary.withValues(alpha: 0.5),
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    suffixIcon: IconButton(
                      onPressed: () {
                        context.read<SearchCubit>().searchUser(controller.text.trim());
                      },
                      icon: Icon(Icons.search, color: colors.primary),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        body: BlocListener<SearchCubit, SearchState>(
          listener: (context, state) {
            if (state is ChatStared) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(
                    chatId: state.chatId,
                    otherUserName: state.otherUser.name,
                  ),
                ),
              );
            }
          },
          child: BlocBuilder<SearchCubit, SearchState>(
            builder: (context, state) {
              if (state is SearchLoading) {
                return Center(
                  child: CircularProgressIndicator(color: colors.primary),
                );
              }

              if (state is SearchFailure) {
                return Center(
                  child: Text(
                    state.errorMessage,
                    style: textStyles.labelText.copyWith(color: Colors.red),
                  ),
                );
              }

              if (state is SearchSuccess) {
                if (state.users.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search_off,
                            size: 60,
                            color: colors.textSecondary.withValues(alpha: 0.3)),
                        const SizedBox(height: 16),
                        Text("No users found", style: textStyles.headerSecondary),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  itemCount: state.users.length,
                  itemBuilder: (context, index) {
                    final user = state.users[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: colors.surface,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: colors.primaryBorder.withValues(alpha: 0.4)),
                        boxShadow: [
                          BoxShadow(
                            color: colors.primary.withValues(alpha: 0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          highlightColor: colors.primary.withValues(alpha: 0.1),
                          splashColor: colors.secondary.withValues(alpha: 0.1),
                          onTap: () {
                            context.read<SearchCubit>().startChat(user);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: colors.primaryGradient,
                                  ),
                                  child: CircleAvatar(
                                    radius: 24,
                                    backgroundColor: colors.surface,
                                    child: Icon(
                                      Icons.person,
                                      color: colors.primary,
                                      size: 24,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Text(
                                    user.name,
                                    style: textStyles.textButtonPrimary.copyWith(
                                      color: colors.textPrimary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.chat_bubble_outline,
                                  color: colors.primary.withValues(alpha: 0.7),
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                              ],
                            ),
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
      ),
    );
  }
}
