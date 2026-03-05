import 'dart:async';

import 'package:chatapp/home/model/chat_item_model.dart';
import 'package:chatapp/home/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  StreamSubscription? streamSubscription;

  void getUserChats() {
    emit(GetChatLoading());
    try {
      final currentUser = FirebaseAuth.instance.currentUser!.uid;
      streamSubscription = FirebaseFirestore.instance
          .collection("chats")
          .where("users", arrayContains: currentUser)
          .snapshots()
          .listen(
            (snapshot) async {
              try {
                List<ChatItemModel> chats = [];
                final docs = snapshot.docs.map((doc) async {
                  final data = doc.data();

                  String otherUserId = data["users"][0] == currentUser
                      ? data["users"][1]
                      : data["users"][0];

                  final otherUserDoc = await FirebaseFirestore.instance
                      .collection("user")
                      .doc(otherUserId)
                      .get()
                      .then((value) {
                        return UserModel.fromJson(
                          value.data() ?? {},
                          docId: value.id,
                        );
                      });

                  return ChatItemModel.fromJson(data, otherUserDoc, doc.id);
                }).toList();
                chats = await Future.wait(docs);

                if (!isClosed) emit(GetChatSuccess(chats: chats));
              } catch (e) {
                if (!isClosed) emit(GetChatFailure(errorMessage: e.toString()));
              }
            },
            onError: (error) {
              if (!isClosed) {
                emit(GetChatFailure(errorMessage: error.toString()));
                debugPrint(error.toString());
              }
            },
          );
    } on FirebaseException catch (e) {
      if (!isClosed) {
        debugPrint(e.message.toString());
        emit(GetChatFailure(errorMessage: e.message.toString()));
      }
    } catch (e) {
      if (!isClosed) {
        debugPrint(e.toString());
        emit(GetChatFailure(errorMessage: e.toString()));
      }
    }
  }

  @override
  Future<void> close() {
    streamSubscription?.cancel();
    return super.close();
  }
}
