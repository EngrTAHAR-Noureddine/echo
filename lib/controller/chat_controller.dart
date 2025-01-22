import 'package:echo/bloc/bloc/chat/chat_bloc.dart';
import 'package:echo/bloc/cubit/app_cubit.dart';
import 'package:echo/model/chat.dart';
import 'package:echo/utils/app_singleton.dart';
import 'package:flutter/material.dart';

class ChatController {
  final String receiverId;
  final String displayName;
  final bool isUserActive;

  ChatController(
      {required this.receiverId,
      required this.displayName,
      required this.isUserActive}) {
    getMessages();
    nameReceiver = MainState<String>(displayName);
    isActive = MainState<bool>(isUserActive);
  }

  final ChatBloc chatBloc = ChatBloc();
  final ChatBloc sendChatBloc = ChatBloc();
  late MainState<String> nameReceiver;
  late MainState<bool> isActive;
  final TextEditingController messageController = TextEditingController();

  void getMessages() => chatBloc.add(GetMessagesEvent(receiverId: receiverId));

  void sendMessage() {
    print(
        "messageController.text.isNotEmpty : ${messageController.text.isNotEmpty}");
    if (messageController.text.isNotEmpty) {
      sendChatBloc.add(SendMessageEvent(
          message: Chat(
              sender: "${AppSingleton.instance.user?.id}",
              receiver: receiverId,
              message: messageController.text,
              isRead: false,
              dateTime: DateTime.now(),
              isDelivered: false)));
    }
  }
}
