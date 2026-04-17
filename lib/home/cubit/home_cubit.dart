import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:chatapp/home/model/chat_item_model.dart';
import 'package:chatapp/home/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  StreamSubscription? streamSubscription;
  final supabase = Supabase.instance.client;
  final userId = FirebaseAuth.instance.currentUser!.uid;
  Future<String?> uploadImage() async {
    try {
      final picker = ImagePicker();
      final pickedfile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );
      if (pickedfile == null) return null;
      final file = File(pickedfile.path);
      final fileName = DateTime.now().millisecondsSinceEpoch.toString();

      final path = 'user/$userId/$fileName.jpg';
      await supabase.storage.from("images").upload(path, file);
      // get urlimage
      final url = supabase.storage.from("images").getPublicUrl(path);

      log("url image $url");
      await saveImageToFireStore(url);
      return url;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<String?> getUserImage() async {
    try {
      final files = await supabase.storage
          .from("images")
          .list(path: "user/$userId");

      if (files.isEmpty) return null;

      final images = files.map((file) {
        return supabase.storage
            .from("images")
            .getPublicUrl("user/$userId/${file.name}");
      }).toList();

      return images.reversed.first;
    } catch (e) {
      debugPrint("Error fetching user image: $e");
      return null;
    }
  }

  Future saveImageToFireStore(String imageUrl) async {
    try {
      final userRef = FirebaseFirestore.instance.collection("user").doc(userId);
      await userRef.update({"image": imageUrl});
    } catch (e) {
      debugPrint(e.toString());
    }
  }

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
                  List users = data["users"] ?? [];
                  log("users $users");

                  if (users.length < 2) {
                    throw Exception("Invalid chat users data");
                  }

                  String otherUserId = users[0] == currentUser
                      ? users[1]
                      : users[0];
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
                  log("otherUserDoc ${otherUserDoc.name}");

                  return ChatItemModel.fromJson(data, otherUserDoc, doc.id);
                }).toList();
                chats = await Future.wait(docs);

                final imageUrl = await getUserImage();
                if (!isClosed) {
                  final fcmToken = await FirebaseMessaging.instance.getToken();
                  // 3 set data in firestore
                  await FirebaseFirestore.instance
                      .collection("user")
                      .doc(currentUser)
                      .update({"fcmToken": fcmToken});
                  emit(GetChatSuccess(chats: chats, imageUrl: imageUrl));
                }
              } catch (e) {
                log(e.toString());
                if (!isClosed) emit(GetChatFailure(errorMessage: e.toString()));
              }
            },
            onError: (error) {
              if (!isClosed) {
                emit(GetChatFailure(errorMessage: error.toString()));
                log(error.toString());
              }
            },
          );
    } on FirebaseException catch (e) {
      if (!isClosed) {
        log(e.message.toString());
        emit(GetChatFailure(errorMessage: e.message.toString()));
      }
    } catch (e) {
      if (!isClosed) {
        log(e.toString());
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
