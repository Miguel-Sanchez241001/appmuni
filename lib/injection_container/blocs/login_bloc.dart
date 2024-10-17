import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Cubit<bool> {
  LoginBloc() : super(false);

  void showPassword(bool isVisible) {
    emit(isVisible);
  }
}
