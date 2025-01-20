import 'package:echo/constant/screen_routes.dart';
import 'package:flutter/material.dart';

class ChatTile extends StatelessWidget {
  const ChatTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context).pushNamed(NavigationRoutes.chat);
      },
      leading: CircleAvatar(
        backgroundColor: Colors.grey,
      ),
      title: Text(
        "User User",
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      subtitle: Text(
        "new message",
        style: Theme.of(context).textTheme.bodySmall,
      ),
      trailing: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "09: 30 AM",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w900,
                fontSize: 10,
                color: Theme.of(context).colorScheme.onSecondary.withAlpha(90)),
          ),
          SizedBox(
            width: 4,
            height: 4,
          ),
          CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            radius: 10,
            child: Text(
              "3",
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
            ),
          )
        ],
      ),
    );
  }
}
