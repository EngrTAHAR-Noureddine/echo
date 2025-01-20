import 'package:flutter_bloc/flutter_bloc.dart';

class MainState<T> extends Cubit<T> {

  MainState(super.initialState);

  void setState({required T newState}) => emit(newState);

  @override
  void onChange(Change<T> change) {
    super.onChange(change);
  }

}