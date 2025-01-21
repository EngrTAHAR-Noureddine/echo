part of 'chat_bloc.dart';

abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatError extends ChatState {
  final String message;
  ChatError({required this.message});
}

class ChatSentSuccessfully extends ChatState {}

class ChatsSuccess extends ChatState {
  final List<ReceiverMessages> receiverMessages;
  ChatsSuccess({required this.receiverMessages});
}
