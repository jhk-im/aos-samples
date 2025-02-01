class Message {
  Message({required this.message,required this.sender});
  String message;
  String sender;

  Message.fromJson(Map<String, Object?> json) : this(
    message: json['message']! as String,
    sender: json['sender']! as String,
  );

  Map<String, Object?> toJson() {
    return {
      'message': message,
      'sender': sender,
    };
  }
}