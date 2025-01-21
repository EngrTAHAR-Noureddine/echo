import 'package:firebase_auth/firebase_auth.dart';

class FireAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<String?> get onAuthStateChanged =>
      _firebaseAuth.authStateChanges().map(
            (User? user) => user?.uid,
          );

  Future<String?> createUserWithEmailAndPassword(
      String email, String password) async {
    return (await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    ))
        .user
        ?.uid;
  }

  Future<String?> currentUserToken() async {
    return _firebaseAuth.currentUser?.uid;
  }

  Future<String?> signInWithEmailAndPassword(
      String email, String password) async {
    return (await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    ))
        .user
        ?.uid;
  }

  Future<void> signOut() {
    return _firebaseAuth.signOut();
  }
}
