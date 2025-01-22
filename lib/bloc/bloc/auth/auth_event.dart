part of 'auth_bloc.dart';

abstract class AuthEvent {}

class SignInEvent extends AuthEvent {
  final String email;
  final String password;
  SignInEvent({required this.password, required this.email});
}

class SignUpEvent extends AuthEvent {
  final String email;
  final String password;
  final String fcmToken;
  final String displayName;
  SignUpEvent(
      {required this.password,
      required this.fcmToken,
      required this.email,
      required this.displayName});
}

class SignOutEvent extends AuthEvent {}

class GetProfileEvent extends AuthEvent {}
