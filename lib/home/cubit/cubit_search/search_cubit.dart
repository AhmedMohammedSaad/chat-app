import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chatapp/home/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show immutable;

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());
  Future searchUser(String query) async {
    if (query.isEmpty) return;
    emit(SearchLoading());

    try {
      final snapShot = await FirebaseFirestore.instance
          .collection("user")
          .where("name", isGreaterThanOrEqualTo: query)
          .where('name', isLessThanOrEqualTo: query)
          .get();
      final users = snapShot.docs.map((e) {
        return UserModel.fromJson(e.data(), docId: e.id);
      });
      final currentUserId = FirebaseAuth.instance.currentUser!.uid;
      final filteredUser = users
          .where((user) => user.id != currentUserId)
          .toList();
      emit(SearchSuccess(users: filteredUser));
    } on Exception catch (e) {
      emit(SearchFailure(errorMessage: e.toString()));
    }
  }

  Future startChat(UserModel user) async {
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;

    try {
      final chatQuery = await FirebaseFirestore.instance
          .collection("chats")
          .where("users", arrayContains: currentUserId)
          .get();
      String? existingChatId;

      for (var doc in chatQuery.docs) {
        final users = List<String>.from(doc['users']);
        if (users.contains(user.id)) {
          existingChatId = doc.id;
          break;
        }
      }
      if (existingChatId != null) {
        emit(ChatStared(chatId: existingChatId, otherUser: user));
      } else {
        final newChatRef = FirebaseFirestore.instance.collection("chats").doc();
        await newChatRef.set({
          'users': [currentUserId, user.id],
          'messages': [],
        });

        emit(ChatStared(chatId: newChatRef.id, otherUser: user));
      }
    } on Exception catch (e) {
      emit(SearchFailure(errorMessage: e.toString()));
    }
  }
}
