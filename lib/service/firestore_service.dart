import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echo/model/chat.dart';
import 'package:echo/model/user.dart';
import 'package:echo/utils/app_singleton.dart';

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
      // print("getUser : id = $id");
      QuerySnapshot querySnapshot = await _db
          .collection(Collection.users.name)
          .where('id', isEqualTo: id)
          .get();
      // print("querySnapshot.docs.isNotEmpty = ${querySnapshot.docs.isNotEmpty}");
      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot snapshot = querySnapshot.docs.first;
        // print("snapshot = ${snapshot.id}");
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        User user = User.fromMap(data);
        User newUser = user.copy(
            activate:
                (AppSingleton.instance.user?.id == user.id) ? true : null);
        // print("user is activate : ${user.isActive}");
        if (!user.isActive) {
          await querySnapshot.docs.first.reference.update(newUser.toJson());
        }

        return newUser;
      } else {
        throw "User not found";
      }
    } catch (e) {
      throw e.toString();
    }
  }

  // Future<bool> setIsReadIt({required Chat message}) async {
  //   try {
  //     QuerySnapshot snapshot = await FirebaseFirestore.instance
  //         .collection(Collection.chat.name)
  //         .where('id', isEqualTo: message.id)
  //         .get();
  //
  //     DocumentReference userDocRef = snapshot.docs.first.reference;
  //
  //     Chat newChat = Chat(
  //         message: message.message,
  //         dateTime: message.dateTime,
  //         isDelivered: message.isDelivered,
  //         isRead: true,
  //         receiver: message.receiver,
  //         sender: message.sender,
  //         id: message.id);
  //
  //     await userDocRef.update(newChat.toJson());
  //
  //     return true;
  //   } catch (_) {
  //     return false;
  //   }
  // }
  //
  // Future<bool> setIsDeliveredIt({required Chat message}) async {
  //   try {
  //     QuerySnapshot snapshot = await FirebaseFirestore.instance
  //         .collection(Collection.chat.name)
  //         .where('id', isEqualTo: message.id)
  //         .get();
  //
  //     DocumentReference userDocRef = snapshot.docs.first.reference;
  //
  //     Chat newChat = Chat(
  //         message: message.message,
  //         dateTime: message.dateTime,
  //         isDelivered: true,
  //         isRead: message.isRead,
  //         receiver: message.receiver,
  //         sender: message.sender,
  //         id: message.id);
  //
  //     await userDocRef.update(newChat.toJson());
  //
  //     return true;
  //   } catch (_) {
  //     return false;
  //   }
  // }

  Future<bool> sendMessage({required Chat message}) async {
    try {
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

      final stream = chatCollection
          .where('sender', whereIn: [receiverId, ownerId]).where('receiver',
              whereIn: [receiverId, ownerId]).snapshots();

      // Combine streams using merge
      final mergedStream =
          stream; //ConcatEagerStream([receiverStream, senderStream]);
      // Listen to the merged stream and process documents
      await for (final querySnapshot in mergedStream) {
        final List<DocumentSnapshot> allDocs = querySnapshot.docs;
        if (allDocs.isNotEmpty) {
          List<Chat> messages = [];
          for (var doc in allDocs) {
            Chat chat = Chat.fromMap(doc.data() as Map<String, dynamic>);
            if (chat.receiver == ownerId &&
                chat.sender == receiverId &&
                !chat.isRead) {
              Chat newChat = chat.copy(deliveredIt: true, readIt: true);
              await doc.reference.update(newChat.toJson());
              messages.add(newChat);
            } else {
              messages.add(chat);
            }
          }
          messages.sort((a, b) => b.dateTime.compareTo(a.dateTime));
          yield messages; // Yield the processed list of Chat objects
        }
      }
      yield [];
    } catch (e) {
      // throw e.toString();
      yield [];
    }
  }

  Stream<List<Chat>> getOwnMessages() async* {
    try {
      final CollectionReference chatCollection =
          FirebaseFirestore.instance.collection(Collection.chat.name);

      final ownerId = AppSingleton.instance.user?.id;

      // Stream for receiver messages
      final streams = chatCollection
          .where(
            Filter.or(
              Filter("sender", isEqualTo: ownerId),
              Filter("receiver", isEqualTo: ownerId),
            ),
          )
          .snapshots();

      await for (final querySnapshot in streams) {
        final List<DocumentSnapshot> allDocs = querySnapshot.docs;
        if (allDocs.isNotEmpty) {
          List<Chat> messages = [];
          for (var doc in allDocs) {
            Chat chat = Chat.fromMap(doc.data() as Map<String, dynamic>);
            if (chat.receiver == ownerId && !chat.isDelivered) {
              Chat newChat = chat.copy(deliveredIt: true, readIt: null);
              await doc.reference.update(newChat.toJson());
              messages.add(newChat);
            } else {
              messages.add(chat);
            }
          }
          messages.sort((a, b) => b.dateTime.compareTo(a.dateTime));
          yield messages; // Yield the processed list of Chat objects
        }
        // if (allDocs.isNotEmpty) {
        //   final messages = allDocs
        //       .map((doc) => Chat.fromMap(doc.data() as Map<String, dynamic>))
        //       .toList();
        //   messages.sort((a, b) => b.dateTime.compareTo(a.dateTime));
        //   yield messages; // Yield the processed list of Chat objects
        // }
      }
      yield [];
    } catch (e) {
      // throw e.toString();
      yield [];
    }
  }

  Future<List<User>> getContacts({required String userId}) async {
    try {
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
        return contacts;
      }
      return [];
    } catch (e) {
      throw e.toString();
    }
  }
}
