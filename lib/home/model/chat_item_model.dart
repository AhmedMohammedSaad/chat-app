import 'package:chatapp/home/model/messages.dart';
import 'package:chatapp/home/model/user_model.dart';

class ChatItemModel {
  final String id;
  final String? name;
  final String? image;
  final List<Messages> message;

  final List<dynamic>? users;
  ChatItemModel({
    required this.id,
    required this.name,
    required this.image,
    required this.message,

    required this.users,
  });
  factory ChatItemModel.fromJson(
    Map<String, dynamic> json,
    UserModel userModel,
    String id,
  ) {
    final rawMessages = json["messages"] as List? ?? [];

    return ChatItemModel(
      id: id,
      name: userModel.name,
      image: userModel.image ?? "",
      message: rawMessages.map((e) => Messages.fromJson(e)).toList(),
      users: List<String>.from(json["users"] ?? []),
    );
  }
}
