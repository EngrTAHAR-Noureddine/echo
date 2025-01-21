import 'package:echo/data/hivebase.dart';
import 'package:echo/model/user.dart';
import 'package:echo/service/firestore_service.dart';

class FirestoreRepository {
  final FirestoreService _service = FirestoreService();

  Future<String> createUser(
          {required String id,
          required String email,
          required String displayName}) async =>
      await _service.createUser(id: id, email: email, displayName: displayName);

  Future<User> getUser({required String id}) async {
    User user = await _service.getUser(id: id);

    HiveBase.hiveBase.setUser(user);

    return user;
  }
}
