import 'package:echo/bloc/bloc/user/user_bloc.dart';
import 'package:echo/component/contact_tile.dart';
import 'package:echo/controller/contacts_controller.dart';
import 'package:echo/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactsScreen extends StatelessWidget {
  factory ContactsScreen({Key? key}) {
    ContactsController controller = ContactsController();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    return ContactsScreen._(key: key, controller: controller);
  }

  const ContactsScreen._({super.key, required this.controller});

  final ContactsController controller;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: RefreshIndicator(
          onRefresh: () async {
            controller.getContacts();
            return Future.delayed(Duration(milliseconds: 200));
          },
          child: BlocBuilder<UserBloc, UserState>(
              bloc: controller.userBloc,
              builder: (context, state) {
                if (state is UserLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is UserError) {
                  return Center(
                    child: Text(
                      state.message,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.error),
                    ),
                  );
                } else if (state is UsersSuccess) {
                  List<User> users = state.users;
                  return ListView.separated(
                      itemCount: users.length,
                      separatorBuilder: (context, state) => SizedBox(
                            width: 8,
                            height: 8,
                          ),
                      itemBuilder: (context, index) => ContactTile(
                            user: users[index],
                          ));
                }

                return Container();
              })),
    );
  }
}
