import 'package:echo/bloc/bloc/auth/auth_bloc.dart';
import 'package:echo/constant/screen_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  final AuthBloc authBloc;

  factory SettingsScreen({Key? key}) {
    final AuthBloc authBloc = AuthBloc();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    return SettingsScreen._(key: key, authBloc: authBloc);
  }

  const SettingsScreen._({super.key, required this.authBloc});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            "Language",
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          subtitle: Text(
            "English",
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
        ListTile(
          title: Text(
            "Theme Mode",
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          subtitle: Text(
            "Light Mode",
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
        SizedBox(
          height: 48,
          width: 48,
        ),
        BlocConsumer<AuthBloc, AuthState>(
          bloc: authBloc,
          listener: (context, state) {
            if (state is AuthSuccess) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  NavigationRoutes.login, (route) => route.isFirst);
            } else if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  state.message,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Theme.of(context).colorScheme.onError),
                ),
                backgroundColor: Theme.of(context).colorScheme.error,
              ));
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              );
            }
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton(
                onPressed: () => authBloc.add(SignOutEvent()),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Logout",
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
