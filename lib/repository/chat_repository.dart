import 'package:echo/model/chat.dart';
import 'package:echo/service/firestore_service.dart';

class ChatRepository {
  final FirestoreService _service = FirestoreService();

  Future<bool> sendMessage(
      {required tokenReceiver, required Chat message}) async {
    bool isSent = await _service.sendMessage(message: message);
    // if (isSent) {
    //   FireMessageService.instance
    //       .sendMessage(tokenReceiver: tokenReceiver, chat: message);
    // }

    return isSent;
  }

  Stream<List<Chat>> getMessages({required String receiverId}) async* {
    yield* _service.getMessages(receiverId: receiverId);
  }

  Stream<List<Chat>> getMyMessages() async* {
    yield* _service.getMyMessages();
  }
}
