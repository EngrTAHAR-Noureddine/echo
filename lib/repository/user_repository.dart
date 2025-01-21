import 'package:echo/data/hivebase.dart';
import 'package:echo/model/user.dart';
import 'package:echo/service/firestore_service.dart';
import 'package:echo/utils/app_singleton.dart';

class UserRepository {
  final FirestoreService _service = FirestoreService();

  Future<String> createUser(
          {required String id,
          required String email,
          required String displayName}) async =>
      await _service.createUser(id: id, email: email, displayName: displayName);

  Future<User> getUser({required String id}) async {
    User user = await _service.getUser(id: id);

    await HiveBase.hiveBase.setUser(user);

    await setIsActive();

    return user;
  }

  Future<List<User>> getContacts() async =>
      await _service.getContacts(userId: AppSingleton.instance.user?.id ?? "");

  Future<bool> setIsActive() async {
    if (AppSingleton.instance.user != null) {
      return await _service.setIsActive(user: AppSingleton.instance.user!);
    }
    return false;
  }
}
