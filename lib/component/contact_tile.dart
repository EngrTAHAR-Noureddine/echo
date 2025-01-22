import 'package:echo/constant/screen_routes.dart';
import 'package:echo/model/user.dart';
import 'package:flutter/material.dart';

class ContactTile extends StatelessWidget {
  final User user;
  const ContactTile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context).pushNamed(NavigationRoutes.chat,
            arguments: [user.id, user.displayName, user.isActive]);
      },
      leading: CircleAvatar(
        backgroundColor: user.isActive
            ? Theme.of(context).colorScheme.secondaryContainer
            : Theme.of(context).indicatorColor,
      ),
      title: Text(
        user.displayName,
        style: Theme.of(context).textTheme.displayMedium,
      ),
    );
  }
}
