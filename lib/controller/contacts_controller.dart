import 'package:echo/bloc/bloc/user/user_bloc.dart';

class ContactsController {
  final UserBloc userBloc;

  void getContacts() => userBloc.add(GetContactsEvent());

  ContactsController({required this.userBloc});
}
