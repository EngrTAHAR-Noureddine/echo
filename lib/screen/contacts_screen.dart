import 'package:echo/component/contact_tile.dart';
import 'package:flutter/material.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: ListView.separated(
          itemCount: 20,
          separatorBuilder: (context, state) => SizedBox(
                width: 8,
                height: 8,
              ),
          itemBuilder: (context, index) => ContactTile()),
    );
  }
}
