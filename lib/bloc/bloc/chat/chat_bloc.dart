import 'dart:async';

import 'package:echo/model/chat.dart';
import 'package:echo/repository/chat_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository _chatRepository = ChatRepository();

  StreamSubscription? _chatSubscription; // Keep track of the subscription

  ChatBloc() : super(ChatInitial()) {
    on<SendMessageEvent>(_sendMessage);
    on<GetMessagesEvent>(_getMessages);
  }

  Future<void> _sendMessage(
      SendMessageEvent event, Emitter<ChatState> emit) async {
    emit(ChatLoading());
    try {
      bool _ = await _chatRepository.sendMessage(message: event.message);
      emit(ChatSentSuccessfully());
    } catch (e) {
      emit(ChatError(message: e.toString()));
    }
  }

  Future<void> _getMessages(
      GetMessagesEvent event, Emitter<ChatState> emit) async {
    emit(ChatLoading());
    try {
      Stream<List<Chat>> chatStream = event.receiverId != null
          ? _chatRepository.getMessages(receiverId: event.receiverId!)
          : _chatRepository.getOwnMessages();

      _chatSubscription = chatStream.listen((chats) {
        emit(ChatsSuccess(chats: chats));
      }, onError: (error) {
        emit(ChatError(message: error.toString()));
      }, onDone: () {
        _chatSubscription?.cancel();
      });
    } catch (e) {
      emit(ChatError(message: e.toString()));
    }
  }

  @override
  Future<void> close() {
    _chatSubscription?.cancel(); // Cancel the subscription
    return super.close();
  }
}
