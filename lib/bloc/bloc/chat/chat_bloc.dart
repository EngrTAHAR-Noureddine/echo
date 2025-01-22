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
    on<StopReceiveMessagesEvent>(_stopReceiveMessages);
  }
  void _stopReceiveMessages(
      StopReceiveMessagesEvent event, Emitter<ChatState> emit) {
    _chatSubscription = null;
    emit(ChatInitial());
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

  void _setSuccess(SetSuccess event, Emitter<ChatState> emit) =>
      emit(ChatsSuccess(receiverMessages: event.receiverMessages));

  void _setFailure(SetFailure event, Emitter<ChatState> emit) =>
      emit(ChatError(message: event.message));

  Future<void> _getMessages(
      GetMessagesEvent event, Emitter<ChatState> emit) async {
    emit(ChatLoading());
    try {
      Stream<List<Chat>> chatStream = event.receiverId != null
          ? _chatRepository.getMessages(receiverId: event.receiverId!)
          : _chatRepository.getOwnMessages();
      _chatSubscription = chatStream.listen((chats) async {
        List<ReceiverMessages> receiverMessages =
            chats.convertChatsToReceiverMessages;

        if (receiverMessages.isNotEmpty) {
          for (var element in receiverMessages) {
            User user = await _userRepository.getUser(id: element.receiver);
            element.user = user;
          }
        }

        add(SetSuccess(receiverMessages: receiverMessages));
      }, onError: (error) {
        add(SetFailure(message: error.toString()));
      }, onDone: () {
        add(SetSuccess(receiverMessages: []));
      });
    } catch (e) {
      emit(ChatError(message: e.toString()));
    }
  }

  // @override
  // Future<void> close() {
  //   _chatSubscription?.cancel(); // Cancel the subscription
  //   return super.close();
  // }
}
