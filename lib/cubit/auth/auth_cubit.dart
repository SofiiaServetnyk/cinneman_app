import 'package:cinneman/cubit/auth/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  // TODO: Retrieve initial state from Shared Preferences.
  AuthCubit() : super(Unauthorized());

  void loginAsGuest() {
    emit(Guest());
  }

  void loginUser() {
    emit(Authenticated());
  }

  void logoutUser() {
    emit(Unauthorized());
  }
}
