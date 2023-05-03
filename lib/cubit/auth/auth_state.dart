abstract class AuthState {
  final bool isAuthenticated;
  final bool isAnonymous;

  AuthState({required this.isAuthenticated, required this.isAnonymous});
}

class Unauthorized extends AuthState {
  Unauthorized() : super(isAnonymous: true, isAuthenticated: false);
}

class Guest extends AuthState {
  Guest() : super(isAnonymous: true, isAuthenticated: true);
}

class Authenticated extends AuthState {
  Authenticated() : super(isAnonymous: false, isAuthenticated: true);
}
