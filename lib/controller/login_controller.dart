import 'package:echo/bloc/bloc/auth/auth_bloc.dart';
import 'package:echo/bloc/cubit/app_cubit.dart';
import 'package:flutter/material.dart';

class LoginController {
  /// Login Screen Controller
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController displayNameController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final AuthBloc authBloc = AuthBloc();
  final MainState<bool> isSignUp = MainState<bool>(false);

  void onTap() {
    if (formKey.currentState!.validate()) {
      authBloc.add(isSignUp.state
          ? SignUpEvent(
              password: passwordController.text,
              email: emailController.text,
              displayName: displayNameController.text)
          : SignInEvent(
              password: passwordController.text, email: emailController.text));
    }
  }
}
