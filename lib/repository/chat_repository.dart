import 'package:echo/model/chat.dart';
import 'package:echo/service/firestore_service.dart';

class ChatRepository {
  final FirestoreService _service = FirestoreService();

  Future<bool> sendMessage({required Chat message}) async =>
      _service.sendMessage(message: message);

  Stream<List<Chat>> getMessages({required String receiverId}) async* {
    yield* _service.getMessages(receiverId: receiverId);
  }

  Stream<List<Chat>> getOwnMessages() async* {
    yield* _service.getOwnMessages();
  }
}
