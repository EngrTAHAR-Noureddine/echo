import 'package:echo/model/user.dart';

class AppSingleton {
  /// private constructor
  AppSingleton._();

  /// the one and only instance of this singleton
  static final instance = AppSingleton._();

  User? _user;

  User? get user => _user;

  set setUser(User? user) {
    _user = user;
  }
}
