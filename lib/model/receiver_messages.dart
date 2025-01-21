import 'package:echo/model/chat.dart';
import 'package:echo/model/user.dart';
import 'package:echo/utils/extensions.dart';

class ReceiverMessages {
  final String receiver;
  final List<Chat> messages;
  final Chat lastMessage;

  int get unreadMessages => messages.unreadMessages.length;

  User? user;

  ReceiverMessages(
      {required this.messages,
      required this.receiver,
      required this.lastMessage});
}
