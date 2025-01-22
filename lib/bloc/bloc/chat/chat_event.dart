part of 'chat_bloc.dart';

abstract class ChatEvent {}

class SendMessageEvent extends ChatEvent {
  final Chat message;
  final String tokenReceiver;
  SendMessageEvent({required this.message, required this.tokenReceiver});
}

class GetMessagesEvent extends ChatEvent {
  final String? receiverId;
  GetMessagesEvent({required this.receiverId});
}

class SetSuccess extends ChatEvent {
  final List<ReceiverMessages> receiverMessages;
  SetSuccess({required this.receiverMessages});
}

class StopReceiveMessagesEvent extends ChatEvent {}

class SetFailure extends ChatEvent {
  final String message;
  SetFailure({required this.message});
}
