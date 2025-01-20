import 'package:echo/bloc/cubit/app_cubit.dart';
import 'package:echo/screen/chats_screen.dart';
import 'package:echo/screen/contacts_screen.dart';
import 'package:flutter/material.dart';

class HomeController {
  final MainState<int> selectedIndex = MainState<int>(0);

  final List<String> titles = ["Messages", "Contacts", "Settings"];

  final List<IconData> icons = [
    Icons.message_outlined,
    Icons.contacts_outlined,
    Icons.settings_outlined
  ];

  final List<Widget> bodies = [ChatsScreen(), ContactsScreen(), ChatsScreen()];
}
