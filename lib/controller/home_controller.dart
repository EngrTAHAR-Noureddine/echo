import 'package:echo/bloc/bloc/auth/auth_bloc.dart';
import 'package:echo/bloc/bloc/chat/chat_bloc.dart';
import 'package:echo/bloc/bloc/user/user_bloc.dart';
import 'package:echo/bloc/cubit/app_cubit.dart';
import 'package:echo/screen/chats_screen.dart';
import 'package:echo/screen/contacts_screen.dart';
import 'package:echo/screen/settings_screen.dart';
import 'package:flutter/material.dart';

class HomeController {
  HomeController() {
    getProfile();

    bodies.addAll([
      ChatsScreen(chatBloc: chatBloc),
      ContactsScreen(
        userBloc: userBloc,
      ),
      SettingsScreen()
    ]);

    chatBloc.add(GetMessagesEvent(receiverId: null));
  }
  final AuthBloc authBloc = AuthBloc();
  final MainState<int> selectedIndex = MainState<int>(0);

  final UserBloc userBloc = UserBloc();
  final ChatBloc chatBloc = ChatBloc();

  final List<String> titles = ["Messages", "Contacts", "Settings"];

  final List<IconData> icons = [
    Icons.message_outlined,
    Icons.contacts_outlined,
    Icons.settings_outlined
  ];

  late List<Widget> bodies = [];

  void getProfile() => authBloc.add(GetProfileEvent());

  void onTap({required int value}) {
    switch (value) {
      case 0:
        chatBloc.add(GetMessagesEvent(receiverId: null));
        break;
      case 1:
        userBloc.add(GetContactsEvent());
        chatBloc.add(StopReceiveMessagesEvent());
        break;
    }
    selectedIndex.setState(newState: value);
  }
}
