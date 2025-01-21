import 'package:echo/model/chat.dart';
import 'package:echo/utils/app_singleton.dart';
import 'package:flutter/material.dart';

class BubbleChat extends StatelessWidget {
  final Chat message;
  const BubbleChat({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    bool isMe = message.sender == AppSingleton.instance.user?.id;
    return Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            margin: EdgeInsets.only(
                left: isMe ? 16 : 0, right: isMe ? 0 : 16, top: 8, bottom: 0),
            decoration: BoxDecoration(
              color: isMe
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(16),
                topLeft: Radius.circular(isMe ? 16 : 0),
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(isMe ? 0 : 16),
              ),
            ),
            alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
            child: Text(
              message.message,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
            ),
          )
        ]);
  }
}
