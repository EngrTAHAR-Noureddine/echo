import 'package:echo/bloc/bloc/chat/chat_bloc.dart';
import 'package:echo/component/chat_tile.dart';
import 'package:echo/controller/chats_controller.dart';
import 'package:echo/model/receiver_messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatsScreen extends StatelessWidget {
  factory ChatsScreen({Key? key}) {
    ChatsController controller = ChatsController();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    return ChatsScreen._(key: key, controller: controller);
  }

  const ChatsScreen._({super.key, required this.controller});

  final ChatsController controller;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: BlocBuilder<ChatBloc, ChatState>(
          bloc: controller.chatBloc,
          builder: (context, state) {
            if (state is ChatLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ChatError) {
              return Center(
                child: Text(
                  state.message,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Theme.of(context).colorScheme.error),
                ),
              );
            } else if (state is ChatsSuccess) {
              List<ReceiverMessages> receiverMessages = state.receiverMessages;
              return ListView.separated(
                  itemCount: receiverMessages.length,
                  separatorBuilder: (context, state) => SizedBox(
                        width: 8,
                        height: 8,
                      ),
                  itemBuilder: (context, index) => ChatTile(
                        receiverMessage: receiverMessages[index],
                      ));
            }

            return Container();
          }),
    );
  }
}
