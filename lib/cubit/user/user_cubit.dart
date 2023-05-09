import 'package:cinneman/cubit/user/user_state.dart';
import 'package:cinneman/services/auth_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserCubit extends Cubit<UserState> {
  final AuthApiService _authApi = AuthApiService();
  final AuthStorage _authStorage = AuthStorage();

  UserCubit() : super(Unauthorized()) {
    Future.delayed(Duration.zero, () => _authStorage.getAuthState())
        .then((state) async {
      if (state is! Unauthorized) {
        var user = await _authApi.getCurrentUser(state.accessToken!);
        if (user == null) {
          // Invalid token, clear session data and stop processing.
          _authStorage.clearAuthInfo();
          return;
        }
      }

      if (state is Authenticated) {
        final tickets = await _authApi.getTickets(state.accessToken!);
        emit(Authenticated(
            accessToken: state.accessToken!,
            phoneNumber: state.phoneNumber!,
            tickets: tickets));
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
      final tickets = await _authApi.getTickets(accessToken);
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
      final tickets = await _authApi.getTickets(accessToken);
      emit(Authenticated(
          accessToken: accessToken,
          phoneNumber: state.phoneNumber!,
          tickets: tickets));
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
      emit(Authenticated(
          accessToken: state.accessToken!,
          phoneNumber: state.phoneNumber!,
          tickets: tickets));
    } else if (state is Guest) {
      final tickets = await _authApi.getTickets(state.accessToken!);
      emit(Guest(accessToken: state.accessToken!, tickets: tickets));
    }
  }

  Future<bool> isTokenValid() async {
    if (state is Authenticated || state is Guest) {
      final user = await _authApi.getCurrentUser(state.accessToken!);
      return user != null;
    } else {
      return false;
    }
  }
}

class AuthStorage {
  static const String _isAnonymousKey = 'anonymous';
  static const String _accessTokenKey = 'access_token';
  static const String _phoneNumberKey = 'phone_number';

  Future<void> saveAuthInfo({
    required bool isAnonymous,
    String? accessToken,
    String? phoneNumber,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isAnonymousKey, isAnonymous);
    await prefs.setString(_accessTokenKey, accessToken ?? '');
    await prefs.setString(_phoneNumberKey, phoneNumber ?? '');
  }

  Future<void> clearAuthInfo() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_isAnonymousKey);
    await prefs.remove(_accessTokenKey);
    await prefs.remove(_phoneNumberKey);
  }

  Future<UserState> getAuthState() async {
    final prefs = await SharedPreferences.getInstance();
    bool? isAnonymous = prefs.getBool(_isAnonymousKey);
    String? accessToken = prefs.getString(_accessTokenKey);
    String? phoneNumber = prefs.getString(_phoneNumberKey);

    if (isAnonymous == null || accessToken == null) {
      return Unauthorized();
    }

    if (isAnonymous || (phoneNumber ?? "").isEmpty) {
      return Guest(accessToken: accessToken);
    } else {
      return Authenticated(accessToken: accessToken, phoneNumber: phoneNumber!);
    }
  }
}
