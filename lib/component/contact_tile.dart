import 'package:flutter/material.dart';

class ContactTile extends StatelessWidget {
  const ContactTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      leading: CircleAvatar(
        backgroundColor: Colors.grey,
      ),
      title: Text(
        "User User",
        style: Theme.of(context).textTheme.displayMedium,
      ),
    );
  }
}
