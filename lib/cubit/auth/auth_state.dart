abstract class AuthState {
  final bool isAuthenticated;
  final bool isAnonymous;
  final String? accessToken;
  final String? phoneNumber;

  AuthState(
      {required this.isAuthenticated,
      required this.isAnonymous,
      this.accessToken,
      this.phoneNumber});
}

class Unauthorized extends AuthState {
  Unauthorized({String? phoneNumber})
      : super(
            isAnonymous: true,
            isAuthenticated: false,
            phoneNumber: phoneNumber);
}

class Guest extends AuthState {
  Guest({required String accessToken})
      : super(
            isAnonymous: true, isAuthenticated: true, accessToken: accessToken);
}

class Authenticated extends AuthState {
  Authenticated({required String accessToken})
      : super(
            isAnonymous: false,
            isAuthenticated: true,
            accessToken: accessToken);
}
