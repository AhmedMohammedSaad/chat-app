class ChatItemModel {
  final String? name;
  final String? image;
  final String? message;
  final String? time;
  final String? unreadCount;
  ChatItemModel({
    required this.name,
    required this.image,
    required this.message,
    required this.time,
    required this.unreadCount,
  });

  factory ChatItemModel.fromJson(Map<String, dynamic> json) => ChatItemModel(
    name: json["name"],
    image: json["image"],
    message: json["message"],
    time: json["time"],
    unreadCount: json["unreadCount"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "image": image,
    "message": message,
    "time": time,
    "unreadCount": unreadCount,
  };
}
