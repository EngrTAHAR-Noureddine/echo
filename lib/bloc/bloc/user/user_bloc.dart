import 'package:echo/model/user.dart';
import 'package:echo/repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository = UserRepository();

  UserBloc() : super(UserInitial()) {
    on<GetContactsEvent>(_getContacts);
  }

  Future<void> _getContacts(
      GetContactsEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      List<User> users = await _userRepository.getContacts();

      emit(UsersSuccess(users: users));
    } catch (e) {
      emit(UserError(message: e.toString()));
    }
  }
}
