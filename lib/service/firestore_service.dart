import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echo/model/chat.dart';
import 'package:echo/model/user.dart';
import 'package:echo/utils/app_singleton.dart';
import 'package:rxdart/rxdart.dart';

enum Collection { users, chat }

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

  Future<bool> setIsActive({required User user}) async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection(Collection.users.name)
          .where('id', isEqualTo: user.id)
          .get();

      DocumentReference userDocRef = snapshot.docs.first.reference;

      User newUser = User(
          id: user.id,
          email: user.email,
          displayName: user.displayName,
          isActive: true);

      await userDocRef.update(newUser.toJson());

      return true;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<bool> sendMessage({required Chat message}) async {
    try {
      print("sendMessage : ${message.toJson()}");
      DocumentReference _ =
          await _db.collection(Collection.chat.name).add(message.toJson());
      return true;
    } catch (e) {
      throw e.toString();
    }
  }

  Stream<List<Chat>> getMessages({required String receiverId}) async* {
    try {
      final CollectionReference chatCollection =
          FirebaseFirestore.instance.collection(Collection.chat.name);

      final ownerId = AppSingleton.instance.user?.id;
      // Stream for receiver messages
      final receiverStream = chatCollection
          .where('receiver', isEqualTo: receiverId)
          .where('sender', isEqualTo: ownerId)
          .snapshots();

      // Stream for sender messages
      final senderStream = chatCollection
          .where('sender', isEqualTo: receiverId)
          .where('receiver', isEqualTo: ownerId)
          .snapshots();

      // Combine streams using merge
      final mergedStream = MergeStream([receiverStream, senderStream]);
      print("mergedStream : ${mergedStream.isBroadcast}");
      // Listen to the merged stream and process documents
      await for (final querySnapshot in mergedStream) {
        final List<DocumentSnapshot> allDocs = querySnapshot.docs;
        if (allDocs.isNotEmpty) {
          final messages = allDocs
              .map((doc) => Chat.fromMap(doc.data() as Map<String, dynamic>))
              .toList();
          messages.sort((a, b) => b.dateTime.compareTo(a.dateTime));
          yield messages; // Yield the processed list of Chat objects
        }
      }
      yield [];
    } catch (e) {
      throw e.toString();
    }
  }

  Stream<List<Chat>> getOwnMessages() async* {
    try {
      final CollectionReference chatCollection =
          FirebaseFirestore.instance.collection(Collection.chat.name);

      final ownerId = AppSingleton.instance.user?.id;
      // Stream for receiver messages
      final receiverStream =
          chatCollection.where('receiver', isEqualTo: ownerId).snapshots();

      // Stream for sender messages
      final senderStream =
          chatCollection.where('sender', isEqualTo: ownerId).snapshots();

      // Combine streams using merge
      final mergedStream = MergeStream([receiverStream, senderStream]);

      // Listen to the merged stream and process documents
      await for (final querySnapshot in mergedStream) {
        final List<DocumentSnapshot> allDocs = querySnapshot.docs;
        if (allDocs.isNotEmpty) {
          final messages = allDocs
              .map((doc) => Chat.fromMap(doc.data() as Map<String, dynamic>))
              .toList();
          messages.sort((a, b) => b.dateTime.compareTo(a.dateTime));
          yield messages; // Yield the processed list of Chat objects
        }
      }
    } catch (e) {
      throw e.toString();
    }
  }

  // Future<List<Chat>> getMessages({required String receiverId}) async {
  //   try {
  //     final CollectionReference chatCollection =
  //         FirebaseFirestore.instance.collection(Collection.chat.name);
  //
  //     // Query where receiver is the userId
  //     final QuerySnapshot receiverQuery =
  //         await chatCollection.where('receiver', isEqualTo: receiverId).get();
  //
  //     // Query where sender is the userId
  //     final QuerySnapshot senderQuery =
  //         await chatCollection.where('sender', isEqualTo: receiverId).get();
  //
  //     // Combine the results, removing duplicates
  //     final List<DocumentSnapshot> allDocs = [];
  //
  //     // Add receiver documents
  //     allDocs.addAll(receiverQuery.docs);
  //     allDocs.addAll(senderQuery.docs);
  //     if (allDocs.isNotEmpty) {
  //       List<Chat> messages = List.generate(
  //           allDocs.length,
  //           (index) =>
  //               Chat.fromMap(allDocs[index].data() as Map<String, dynamic>));
  //
  //       messages.sort((a, b) => b.dateTime.compareTo(a.dateTime));
  //       return messages;
  //     }
  //     return [];
  //   } catch (e) {
  //     throw e.toString();
  //   }
  // }

  Future<List<User>> getContacts({required String userId}) async {
    try {
      print("userId : $userId");
      final CollectionReference chatCollection =
          FirebaseFirestore.instance.collection(Collection.users.name);
      final QuerySnapshot receiverQuery =
          await chatCollection.where('id', isNotEqualTo: userId).get();
      List<DocumentSnapshot> docs = receiverQuery.docs;
      if (docs.isNotEmpty) {
        List<User> contacts = List.generate(
            docs.length,
            (index) =>
                User.fromMap(docs[index].data() as Map<String, dynamic>));
        contacts.removeWhere((element) => element.id == userId);
        print("contacts : ${contacts.length}");
        return contacts;
      }
      return [];
    } catch (e) {
      throw e.toString();
    }
  }
}
