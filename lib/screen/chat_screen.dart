import 'package:echo/bloc/bloc/chat/chat_bloc.dart';
import 'package:echo/bloc/cubit/app_cubit.dart';
import 'package:echo/component/bubble_chat.dart';
import 'package:echo/controller/chat_controller.dart';
import 'package:echo/model/chat.dart';
import 'package:echo/model/receiver_messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatelessWidget {
  factory ChatScreen(
      {Key? key,
      required String receiverId,
      required String displayName,
      required bool isUserActive}) {
    ChatController controller = ChatController(
        receiverId: receiverId,
        displayName: displayName,
        isUserActive: isUserActive);
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    return ChatScreen._(key: key, controller: controller);
  }

  const ChatScreen._({super.key, required this.controller});

  final ChatController controller;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.messageFocus.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: ListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            leading: BlocBuilder<MainState<bool>, bool>(
              bloc: controller.isActive,
              buildWhen: (oldState, newState) => oldState != newState,
              builder: (context, isActive) => CircleAvatar(
                backgroundColor: isActive
                    ? Theme.of(context).colorScheme.secondaryContainer
                    : Theme.of(context).indicatorColor,
              ),
            ),
            title: BlocBuilder<MainState<String?>, String?>(
                bloc: controller.nameReceiver,
                buildWhen: (oldState, newState) => oldState != newState,
                builder: (context, name) => Text("$name",
                    style: Theme.of(context).textTheme.displayMedium)),
            subtitle: BlocBuilder<MainState<bool>, bool>(
                bloc: controller.isActive,
                buildWhen: (oldState, newState) => oldState != newState,
                builder: (context, isActive) => Text(
                    isActive ? "Active now" : "Not active",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(fontSize: 10))),
          ),
          centerTitle: false,
          titleSpacing: 0,
          leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: Theme.of(context).colorScheme.onSecondary,
              )),
        ),
        body: Card(
          elevation: 0,
          margin: EdgeInsets.symmetric(horizontal: 8),
          child: BlocBuilder<ChatBloc, ChatState>(
              bloc: controller.chatBloc,
              builder: (context, state) {
                if (state is ChatLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  );
                } else if (state is ChatError) {
                  return Center(
                    child: Text(
                      state.message,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.error),
                    ),
                  );
                } else if (state is ChatsSuccess) {
                  List<ReceiverMessages> receiverMessages =
                      state.receiverMessages;
                  if (receiverMessages.isNotEmpty) {
                    List<Chat> chats =
                        receiverMessages.first.messages.reversed.toList();
                    controller.nameReceiver.setState(
                        newState: receiverMessages.first.user?.displayName ??
                            receiverMessages.first.receiver);
                    controller.isActive.setState(
                        newState:
                            receiverMessages.first.user?.isActive == true);
                    controller.tokenReceiver =
                        receiverMessages.first.user?.fcmToken;
                    return SingleChildScrollView(
                      reverse: true,
                      child: Column(
                        children: List.generate(
                            chats.length,
                            (index) => BubbleChat(
                                  message: chats[index],
                                )),
                      ),
                    );
                  }
                }
                return Container();
              }),
        ),
        bottomNavigationBar: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            child: TextField(
              focusNode: controller.messageFocus,
              controller: controller.messageController,
              decoration: InputDecoration(
                  suffixIcon: BlocListener<ChatBloc, ChatState>(
                bloc: controller.sendChatBloc,
                listener: (context, state) {
                  if (state is ChatSentSuccessfully) {
                    controller.messageController.clear();
                  } else if (state is ChatError) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        state.message,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onError),
                      ),
                      backgroundColor: Theme.of(context).colorScheme.error,
                    ));
                  }
                },
                child: IconButton(
                    onPressed: () => controller.sendMessage(),
                    icon: Icon(
                      Icons.send,
                      color: Theme.of(context).colorScheme.primary,
                    )),
              )),
            ),
          ),
        ),
      ),
    );
  }
}
