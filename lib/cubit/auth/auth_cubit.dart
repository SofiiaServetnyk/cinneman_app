import 'package:cinneman/cubit/auth/auth_state.dart';
import 'package:cinneman/services/auth_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserCubit extends Cubit<UserState> {
  final AuthApiService _authApi = AuthApiService();
  final AuthStorage _authStorage = AuthStorage();

  UserCubit() : super(Unauthorized()) {
    Future.delayed(Duration.zero, () => _authStorage.getAuthState())
        .then((state) async {
      if (state is Authenticated) {
        final tickets = await _authApi.getTickets(state.accessToken!);
        emit(Authenticated(accessToken: state.accessToken!, tickets: tickets));
      } else if (state is Guest) {
        final tickets = await _authApi.getTickets(state.accessToken!);
        emit(Guest(accessToken: state.accessToken!, tickets: tickets));
      } else {
        emit(state);
      }
    });
  }

  Future<void> loginAsGuest() async {
    final accessToken = await _authApi.getGuestAccessToken();

    if (accessToken != null) {
      await _authStorage.saveAuthInfo(
          isAnonymous: true, accessToken: accessToken);
      final tickets = await _authApi.getTickets(state.accessToken!);
      emit(Guest(accessToken: accessToken, tickets: tickets));
    } else {
      emit(Unauthorized());
    }
  }

  Future<void> enterPhoneNumber(String phoneNumber) async {
    final success = await _authApi.sendOtpRequest(phoneNumber);
    if (success) {
      emit(Unauthorized(phoneNumber: phoneNumber));
    } else {
      emit(Unauthorized());
    }
  }

  Future<void> validateOtp(String otp) async {
    final accessToken =
        await _authApi.getAuthorizedAccessToken(state.phoneNumber!, otp);
    if (accessToken != null) {
      await _authStorage.saveAuthInfo(
          isAnonymous: false, accessToken: accessToken);
      final tickets = await _authApi.getTickets(state.accessToken!);
      emit(Authenticated(accessToken: accessToken, tickets: tickets));
    } else {
      emit(Unauthorized(phoneNumber: state.phoneNumber));
    }
  }

  Future<void> logoutUser() async {
    await _authStorage.clearAuthInfo();
    emit(Unauthorized());
  }

  Future<void> loadTickets() async {
    if (state is Authenticated) {
      final tickets = await _authApi.getTickets(state.accessToken!);
      emit(Authenticated(accessToken: state.accessToken!, tickets: tickets));
    }
    else if (state is Guest) {
      final tickets = await _authApi.getTickets(state.accessToken!);
      emit(Guest(accessToken: state.accessToken!, tickets: tickets));
    }
  }
}

class AuthStorage {
  static const String _isAnonymousKey = 'anonymous';
  static const String _accessTokenKey = 'access_token';

  Future<void> saveAuthInfo({
    required bool isAnonymous,
    String? accessToken,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isAnonymousKey, isAnonymous);
    await prefs.setString(_accessTokenKey, accessToken ?? '');
  }

  Future<void> clearAuthInfo() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_isAnonymousKey);
    await prefs.remove(_accessTokenKey);
  }

  Future<UserState> getAuthState() async {
    final prefs = await SharedPreferences.getInstance();
    bool? isAnonymous = prefs.getBool(_isAnonymousKey);
    String? accessToken = prefs.getString(_accessTokenKey);

    if (isAnonymous == null || accessToken == null) {
      return Unauthorized();
    }

    if (isAnonymous) {
      return Guest(accessToken: accessToken);
    } else {
      return Authenticated(accessToken: accessToken);
    }
  }


}
