import 'package:cinneman/data/models/session_models.dart';
import 'package:cinneman/pages/login_screen.dart';
import 'package:cinneman/pages/movie_details.dart';
import 'package:cinneman/pages/movies_list.dart';
import 'package:cinneman/pages/otp_screen.dart';
import 'package:cinneman/pages/payment_screen.dart';
import 'package:cinneman/pages/seat_selection_screen.dart';
import 'package:cinneman/pages/splash_screen.dart';
import 'package:cinneman/pages/user_screen.dart';
import 'package:cinneman/pages/welcome_screen.dart';
import 'package:flutter/material.dart';

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

class RouteConfig {
  final AppRoutes? route;
  final Object? args;

  RouteConfig({this.route, this.args});
}

class PageGenerator {
  MaterialPage createPage(RouteConfig config) {
    switch (config.route) {
      case AppRoutes.welcomeScreen:
        return MaterialPage(
            child: WelcomePage(), key: ValueKey(AppRoutes.welcomeScreen));

      case AppRoutes.login:
        return MaterialPage(child: LoginPage(), key: ValueKey(AppRoutes.login));

      case AppRoutes.otp:
        return MaterialPage(child: OtpPage(), key: ValueKey(AppRoutes.otp));

      case AppRoutes.moviesListPage:
        return MaterialPage(
            child: MoviesListPage(), key: ValueKey(AppRoutes.moviesListPage));

      case AppRoutes.movieDetailsPage:
        var movieId = config.args as int;

        return MaterialPage(
            child: MovieDetailsPage(movieId: movieId),
            key: ValueKey(AppRoutes.movieDetailsPage));

      case AppRoutes.seatSelectPage:
        var session = config.args as MovieSession;

        return MaterialPage(
            child: SeatSelectionPage(),
            key: ValueKey(AppRoutes.seatSelectPage));

      case AppRoutes.checkoutPage:
        return MaterialPage(
            child: PaymentScreen(), key: ValueKey(AppRoutes.checkoutPage));

      case AppRoutes.userProfile:
        return MaterialPage(
            child: UserScreen(), key: ValueKey(AppRoutes.userProfile));

      case AppRoutes.splash:
      default:
        return MaterialPage(
            child: SplashScreen(), key: ValueKey(AppRoutes.splash));
    }
  }
}
