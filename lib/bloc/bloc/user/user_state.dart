part of 'user_bloc.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserError extends UserState {
  final String message;
  UserError({required this.message});
}

class UsersSuccess extends UserState {
  final List<User> users;
  UsersSuccess({required this.users});
}
