enum AppRoutes {
  splash,

  welcomeScreen,
  login,
  otp,

  moviesListPage,
  movieDetailsPage,
  seatSelectPage,
  checkoutPage,

  userProfile,
  userTickets,
}

class RoutePath {
  final AppRoutes? route;
  final Object? args;

  RoutePath({this.route, this.args});
}
