import 'package:flutter/material.dart';

class BubbleChat extends StatelessWidget {
  final bool isMe;
  const BubbleChat({super.key, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
            child: Text("New Message "),
          )
        ]);
  }
}
