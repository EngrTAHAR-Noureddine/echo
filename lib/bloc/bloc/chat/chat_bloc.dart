import 'dart:async';

import 'package:echo/model/chat.dart';
import 'package:echo/model/receiver_messages.dart';
import 'package:echo/model/user.dart';
import 'package:echo/repository/chat_repository.dart';
import 'package:echo/repository/user_repository.dart';
import 'package:echo/utils/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository _chatRepository = ChatRepository();
  final UserRepository _userRepository = UserRepository();

  StreamSubscription? _chatSubscription; // Keep track of the subscription

  ChatBloc() : super(ChatInitial()) {
    on<SendMessageEvent>(_sendMessage);
    on<GetMessagesEvent>(_getMessages);
    on<SetSuccess>(_setSuccess);
    on<SetFailure>(_setFailure);
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

  Future<void> _setSuccess(SetSuccess event, Emitter<ChatState> emit) async =>
      emit(ChatsSuccess(receiverMessages: event.receiverMessages));
  Future<void> _setFailure(SetFailure event, Emitter<ChatState> emit) async =>
      emit(ChatError(message: event.message));

  Future<void> _getMessages(
      GetMessagesEvent event, Emitter<ChatState> emit) async {
    try {
      print("_getMessages begin");
      Stream<List<Chat>> chatStream = event.receiverId != null
          ? _chatRepository.getMessages(receiverId: event.receiverId!)
          : _chatRepository.getOwnMessages();
      print("_getMessages after chatStream");
      _chatSubscription = chatStream.listen((chats) async {
        print("[_chatSubscription] chats : ${chats.length}");
        List<ReceiverMessages> receiverMessages =
            chats.convertChatsToReceiverMessages;
        print(
            "[_chatSubscription] receiverMessages : ${receiverMessages.length}");

        if (receiverMessages.isNotEmpty) {
          for (var element in receiverMessages) {
            User user = await _userRepository.getUser(id: element.receiver);
            element.user = user;
          }
        }
        print(
            "[_chatSubscription] receiverMessages.isNotEmpty : ${receiverMessages.isNotEmpty}");
        add(SetSuccess(receiverMessages: receiverMessages));
      }, onError: (error) {
        add(SetFailure(message: error.toString()));
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
