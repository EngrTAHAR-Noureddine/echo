import 'package:echo/bloc/bloc/auth/auth_bloc.dart';
import 'package:echo/bloc/cubit/app_cubit.dart';
import 'package:echo/constant/app_color.dart';
import 'package:echo/constant/constant.dart';
import 'package:echo/constant/screen_routes.dart';
import 'package:echo/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        key: controller.scaffoldKey,
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
          child: SingleChildScrollView(
            child: BlocBuilder<MainState<bool>, bool>(
                bloc: controller.isSignUp,
                builder: (context, isSignUp) => Form(
                    key: controller.formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Echo ${isSignUp ? "- SignUp -" : ""}",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary),
                        ),
                        SizedBox(
                          width: 48,
                          height: 48,
                        ),
                        if (isSignUp) ...[
                          TextFormField(
                            controller: controller.displayNameController,
                            decoration: InputDecoration(labelText: "Full Name"),
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Field is required(*)";
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            width: 16,
                            height: 16,
                          ),
                        ],
                        TextFormField(
                          controller: controller.emailController,
                          decoration: InputDecoration(labelText: "Email"),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Email is required(*)";
                            } else if (!emailRegExp.hasMatch(value)) {
                              return "This is not an e-mail";
                            }
                            return null;
                          },
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Password is required(*)";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          width: 16,
                          height: 16,
                        ),
                        BlocConsumer<AuthBloc, AuthState>(
                            bloc: controller.authBloc,
                            listener: (context, state) {
                              if (state is AuthSuccess) {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    NavigationRoutes.home,
                                    (route) => route.isFirst);
                              } else if (state is AuthError) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                    state.message,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onError),
                                  ),
                                  backgroundColor:
                                      Theme.of(context).colorScheme.error,
                                ));
                              }
                            },
                            builder: (context, state) {
                              if (state is AuthLoading) {
                                return Center(
                                  child: CircularProgressIndicator(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                );
                              }

                              return ElevatedButton(
                                onPressed: () => controller.onTap(),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(isSignUp ? "Sign up" : "Login",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium
                                            ?.copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onPrimary))
                                  ],
                                ),
                              );
                            }),
                        SizedBox(
                          width: 32,
                          height: 32,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              isSignUp
                                  ? "you have an account?"
                                  : "you haven't an account ?",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            TextButton(
                                onPressed: () => controller.isSignUp
                                    .setState(newState: !isSignUp),
                                child: Text(isSignUp ? "Login" : "Sign up",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                            decoration:
                                                TextDecoration.underline,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimary)))
                          ],
                        )
                      ],
                    ))),
          ),
        ));
  }
}
