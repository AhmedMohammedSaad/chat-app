class Messages {
  final String? senderId;

  final String? text;
  final String? time;
  Messages({required this.senderId, required this.text, required this.time});
  factory Messages.fromJson(Map<String, dynamic> json) {
    return Messages(
      senderId: json["senderId"] ?? "",

      text: json["text"] ?? "",
      time: json["time"] ?? "",
    );
  }
}
