import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echo/model/user.dart';

enum Collection { users }

class FirestoreService {
  final _db = FirebaseFirestore.instance;

  Future<String> createUser(
      {required String id,
      required String email,
      required String displayName}) async {
    try {
      final user = <String, String>{
        "displayName": displayName,
        "email": email,
        "id": id
      };

      DocumentReference doc =
          await _db.collection(Collection.users.name).add(user);
      return doc.id;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<User> getUser({required String id}) async {
    try {
      QuerySnapshot querySnapshot = await _db
          .collection(Collection.users.name)
          .where('id', isEqualTo: id)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot snapshot = querySnapshot.docs.first;
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

        return User.fromMap(data);
      } else {
        throw "User not found";
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
