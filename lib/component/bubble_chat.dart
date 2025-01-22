import 'package:echo/constant/app_color.dart';
import 'package:echo/model/chat.dart';
import 'package:echo/utils/app_singleton.dart';
import 'package:echo/utils/extensions.dart';
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
          if (isMe) ...[
            Spacer(),
            Text(
              message.dateTime.formatDateTime,
              style:
                  Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 10),
            ),
          ],
          Flexible(
            child: Container(
              padding: EdgeInsets.only(
                  top: 8, left: 16, right: isMe ? 8 : 16, bottom: 8),
              margin: EdgeInsets.only(
                  left: isMe ? 8 : 0, right: isMe ? 0 : 8, top: 8, bottom: 0),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Text(
                      message.message,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                  ),
                  SizedBox(
                    width: 4,
                    height: 4,
                  ),
                  if (isMe)
                    Icon(
                      (message.isDelivered) ? Icons.done_all : Icons.check,
                      color: (message.isRead)
                          ? AppColor.lightCyan
                          : AppColor.lightGrey03,
                      size: 16,
                    ),
                ],
              ),
            ),
          ),
          if (!isMe) ...[
            Text(
              message.dateTime.formatDateTime,
              style:
                  Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 10),
            ),
            Spacer()
          ]
        ]);
  }
}
