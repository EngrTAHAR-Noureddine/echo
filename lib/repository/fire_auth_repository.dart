import 'package:echo/data/hivebase.dart';
import 'package:echo/service/fire_auth_service.dart';

class AuthRepository {
  final FireAuthService _authService = FireAuthService();

  Future<String> signUp(String email, String password) async {
    try {
      String? token =
          await _authService.createUserWithEmailAndPassword(email, password);
      if (token == null) {
        throw "Invalid credentials";
      }
      await HiveBase.hiveBase.setToken(token);
      return token;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String?> currentUserToken() async {
    try {
      String? token = await _authService.currentUserToken();
      if (token != null) {
        await HiveBase.hiveBase.setToken(token);
      }
      return token;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      String? token =
          await _authService.signInWithEmailAndPassword(email, password);
      if (token == null) {
        throw "Invalid credentials";
      }
      await HiveBase.hiveBase.setToken(token);
      return token;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> signOut() async {
    try {
      await _authService.signOut();
    } catch (e) {
      throw e.toString();
    }
  }
}
