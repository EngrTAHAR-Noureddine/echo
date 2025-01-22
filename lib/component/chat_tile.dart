import 'package:echo/constant/app_color.dart';
import 'package:echo/constant/screen_routes.dart';
import 'package:echo/model/receiver_messages.dart';
import 'package:echo/utils/extensions.dart';
import 'package:flutter/material.dart';

class ChatTile extends StatelessWidget {
  final ReceiverMessages receiverMessage;

  const ChatTile({super.key, required this.receiverMessage});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context).pushNamed(NavigationRoutes.chat, arguments: [
          receiverMessage.receiver,
          receiverMessage.user?.displayName,
          receiverMessage.user?.isActive == true
        ]);
      },
      leading: CircleAvatar(
        backgroundColor: receiverMessage.user?.isActive == true
            ? AppColor.lightGreen
            : AppColor.lightGrey03,
      ),
      title: Text(
        "${receiverMessage.user?.displayName}",
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      subtitle: Text(
        receiverMessage.lastMessage.message,
        style: Theme.of(context).textTheme.bodySmall,
      ),
      trailing: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            receiverMessage.lastMessage.dateTime.formatDateTime,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w900,
                fontSize: 10,
                color: Theme.of(context).colorScheme.onSecondary.withAlpha(90)),
          ),
          if (receiverMessage.unreadMessages != 0) ...[
            SizedBox(
              width: 4,
              height: 4,
            ),
            CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              radius: 10,
              child: Text(
                receiverMessage.unreadMessages.toString(),
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
              ),
            )
          ]
        ],
      ),
    );
  }
}
