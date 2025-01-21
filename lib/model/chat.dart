class Chat {
  final String? id;
  final String sender;
  final String receiver;
  final String message;
  final bool isRead;
  final bool isDelivered;
  final DateTime dateTime;

  Chat(
      {this.id,
      required this.sender,
      required this.receiver,
      required this.message,
      required this.isRead,
      required this.dateTime,
      required this.isDelivered});

  factory Chat.fromMap(Map<String, dynamic> map) {
    return Chat(
      id: map['id'],
      sender: map['sender'],
      receiver: map['receiver'],
      message: map['message'],
      isRead: map['isRead'] == "true",
      dateTime: DateTime.parse(map['dateTime']),
      isDelivered: map['isDelivered'] == "true",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "sender": sender,
        "receiver": receiver,
        "message": message,
        "isRead": "$isRead",
        "dateTime": dateTime.toIso8601String(),
        "isDelivered": "$isDelivered"
      };
}
