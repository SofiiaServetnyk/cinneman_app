import 'package:cinneman/cubit/user/user_cubit.dart';
import 'package:cinneman/navigation/app_routes.dart';
import 'package:flutter/material.dart';

class AppRouteInformationParser extends RouteInformationParser<RouteConfig> {
  final UserCubit _authCubit;

  bool get isAuthenticated => _authCubit.state.isAuthenticated;

  AppRouteInformationParser({required UserCubit authCubit})
      : _authCubit = authCubit;

  @override
  Future<RouteConfig> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location ?? '');


    if (!isAuthenticated) {
      switch (uri.path) {
        case '/welcome':
          return RouteConfig(route: AppRoutes.welcomeScreen);
        case '/login':
          return RouteConfig(route: AppRoutes.login);
        case '/login/otp':
          return RouteConfig(route: AppRoutes.otp);
      }
    }


    switch (uri.path) {
      case '/movies':
        return RouteConfig(route: AppRoutes.moviesListPage);
      case '/movie-details':

        if (uri.queryParameters.containsKey('movieId')) {

          return RouteConfig(
              route: AppRoutes.movieDetailsPage,
              args: uri.queryParameters['movieId']);
        }
        return RouteConfig(route: AppRoutes.moviesListPage);
      case '/checkout':
        return RouteConfig(route: AppRoutes.checkoutPage);
      case '/profile':
        return RouteConfig(route: AppRoutes.userProfile);
      case '/tickets':
        return RouteConfig(route: AppRoutes.userTickets);
    }

    return RouteConfig(route: AppRoutes.splash);
  }

  @override
  RouteInformation? restoreRouteInformation(RouteConfig configuration) {
    switch (configuration.route) {

      case AppRoutes.welcomeScreen:
        return const RouteInformation(location: '/welcome');
      case AppRoutes.login:
        return const RouteInformation(location: '/login');
      case AppRoutes.otp:
        return const RouteInformation(location: '/login/otp');
      case AppRoutes.moviesListPage:
        return const RouteInformation(location: '/movies');
      case AppRoutes.movieDetailsPage:

        return const RouteInformation(location: '/movie-details?movieId=example');
      case AppRoutes.checkoutPage:
        return const RouteInformation(location: '/checkout');
      case AppRoutes.userProfile:
        return const RouteInformation(location: '/profile');
      case AppRoutes.userTickets:
        return const RouteInformation(location: '/tickets');
      default:
        return const RouteInformation(location: '/');
    }
  }
}
