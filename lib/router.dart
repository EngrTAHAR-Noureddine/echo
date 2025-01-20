import 'package:echo/constant/screen_routes.dart';
import 'package:echo/screen/chat_screen.dart';
import 'package:echo/screen/home_screen.dart';
import 'package:echo/screen/login_screen.dart';
import 'package:flutter/material.dart';

class RouterGenerator {
  static Route? getRouter(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      /// Dialogs ------------------------------------------------------------
      // case progressDialogRoute:
      //   return ProgressDialog(loadingText: routeSettings.arguments as String?);
      // case confirmDialogRoute:
      //   return ConfirmDialog(text: routeSettings.arguments as String?);
      // case errorDialogRoute:
      //   return ErrorDialog(contents: routeSettings.arguments as String);
      /// Screens ------------------------------------------------------------
      case NavigationRoutes.home:
        return MaterialPageRoute(
          settings: RouteSettings(name: routeSettings.name),
          builder: (context) => HomeScreen(),
        );
      case NavigationRoutes.chat:
        return MaterialPageRoute(
          settings: RouteSettings(name: routeSettings.name),
          builder: (context) => ChatScreen(),
        );
      case NavigationRoutes.login:
        return MaterialPageRoute(
          settings: RouteSettings(name: routeSettings.name),
          builder: (context) => LoginScreen(),
        );
    }
    return null;
  }
}
