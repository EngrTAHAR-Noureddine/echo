import 'package:echo/bloc/bloc/chat/chat_bloc.dart';

class ChatsController {
  final ChatBloc chatBloc = ChatBloc();

  void getChats() => chatBloc.add(GetMessagesEvent(receiverId: null));

  ChatsController() {
    getChats();
  }
}
