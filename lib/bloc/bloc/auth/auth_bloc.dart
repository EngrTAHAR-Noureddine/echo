import 'package:bloc/bloc.dart';
import 'package:echo/data/hivebase.dart';
import 'package:echo/model/user.dart';
import 'package:echo/repository/fire_auth_repository.dart';
import 'package:echo/repository/firestore_repository.dart';
import 'package:echo/utils/app_singleton.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository = AuthRepository();
  final FirestoreRepository _firestoreRepository = FirestoreRepository();

  AuthBloc() : super(AuthInitial()) {
    on<SignInEvent>(_signIn);
    on<SignUpEvent>(_signUp);
    on<SignOutEvent>(_signOut);
    on<GetProfileEvent>(_getProfile);
  }

  Future<void> _signIn(SignInEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      String token = await _authRepository.signInWithEmailAndPassword(
          event.email, event.password);
      User user = await _firestoreRepository.getUser(id: token);
      AppSingleton.instance.setUser = user;

      emit(AuthSuccess());
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _signUp(SignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      String token = await _authRepository.signUp(event.email, event.password);
      String _ = await _firestoreRepository.createUser(
          id: token, email: event.email, displayName: event.displayName);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _signOut(SignOutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _authRepository.signOut();

      emit(AuthSuccess());
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _getProfile(
      GetProfileEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      String? token = await _authRepository.currentUserToken();
      User user = await _firestoreRepository.getUser(
          id: token ?? HiveBase.hiveBase.getToken() ?? "");
      AppSingleton.instance.setUser = user;

      emit(AuthSuccess());
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }
}
