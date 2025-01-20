import 'package:echo/constant/app_color.dart';
import 'package:echo/constant/screen_routes.dart';
import 'package:echo/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatelessWidget {
  factory LoginScreen({Key? key}) {
    LoginController controller = LoginController();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    return LoginScreen._(key: key, controller: controller);
  }

  const LoginScreen._({super.key, required this.controller});

  final LoginController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColor.lightBlue, AppColor.lightCyan],
          begin: Alignment.topCenter,
          end: Alignment.bottomRight,
          stops: [0.0, 1.0],
        ),
      ),
      alignment: Alignment.center,
      padding: EdgeInsets.all(32),
      child: Form(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Echo",
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
          ),
          SizedBox(
            width: 48,
            height: 48,
          ),
          TextFormField(
            controller: controller.emailController,
            decoration: InputDecoration(labelText: "Email"),
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(
            width: 16,
            height: 16,
          ),
          TextFormField(
            controller: controller.passwordController,
            decoration: InputDecoration(labelText: "Password"),
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
          ),
          SizedBox(
            width: 16,
            height: 16,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, NavigationRoutes.home);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Login",
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary))
              ],
            ),
          ),
          SizedBox(
            width: 32,
            height: 32,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "you haven't an account ?",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              TextButton(
                  onPressed: () {},
                  child: Text("Sign up",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          decoration: TextDecoration.underline,
                          color: Theme.of(context).colorScheme.onPrimary)))
            ],
          )
        ],
      )),
    ));
  }
}
