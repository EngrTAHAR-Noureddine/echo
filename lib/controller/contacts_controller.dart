import 'package:echo/bloc/bloc/user/user_bloc.dart';

class ContactsController {
  final UserBloc userBloc = UserBloc();

  void getContacts() => userBloc.add(GetContactsEvent());

  ContactsController() {
    getContacts();
  }
}
