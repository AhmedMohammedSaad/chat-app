import 'package:chatapp/chat/chat_screen.dart';
import 'package:chatapp/home/cubit/cubit_search/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Builder(
            builder: (context) {
              return TextField(
                onSubmitted: (value) {
                  context.read<SearchCubit>().searchUser(
                    controller.text.trim(),
                  );
                },
                controller: controller,
                decoration: InputDecoration(
                  hintText: 'Search .....',
                  suffixIcon: IconButton(
                    onPressed: () {
                      context.read<SearchCubit>().searchUser(
                        controller.text.trim(),
                      );
                    },
                    icon: Icon(Icons.search),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
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
                return const Center(child: CircularProgressIndicator());
              }

              if (state is SearchFailure) {
                return Center(child: Text(state.errorMessage));
              }
              if (state is SearchSuccess) {
                if (state.users.isEmpty) {
                  return Center(child: Text("no Users"));
                }
                return ListView.builder(
                  itemCount: state.users.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color.fromARGB(255, 81, 6, 179),
                      ),
                      child: ListTile(
                        title: Text(
                          state.users[index].name,
                          style: TextStyle(color: Colors.white),
                        ),
                        leading: Icon(Icons.person),
                        onTap: () {
                          context.read<SearchCubit>().startChat(
                            state.users[index],
                          );
                        },
                      ),
                    );
                  },
                );
              } else {
                return SizedBox.shrink();
              }
            },
          ),
        ),
      ),
    );
  }
}
