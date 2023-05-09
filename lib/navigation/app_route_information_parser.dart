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

    // Handle anonymous pages
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

    // Handle authenticated pages
    switch (uri.path) {
      case '/movies':
        return RouteConfig(route: AppRoutes.moviesListPage);
      case '/movie-details':
        // Assuming movieId is a query parameter
        if (uri.queryParameters.containsKey('movieId')) {
          // Pass the movieId as an additional property to RoutePath if needed
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
  RouteInformation? restoreRouteInformation(RouteConfig config) {
    switch (config.route) {
      // case AppRoutes.splash:
      //   return RouteInformation(location: '/');
      case AppRoutes.welcomeScreen:
        return RouteInformation(location: '/welcome');
      case AppRoutes.login:
        return RouteInformation(location: '/login');
      case AppRoutes.otp:
        return RouteInformation(location: '/login/otp');
      case AppRoutes.moviesListPage:
        return RouteInformation(location: '/movies');
      case AppRoutes.movieDetailsPage:
        // Assuming movieId is a query parameter
        // Use the movieId from the RoutePath to build the location
        return RouteInformation(location: '/movie-details?movieId=example');
      case AppRoutes.checkoutPage:
        return RouteInformation(location: '/checkout');
      case AppRoutes.userProfile:
        return RouteInformation(location: '/profile');
      case AppRoutes.userTickets:
        return RouteInformation(location: '/tickets');
      default:
        return RouteInformation(location: '/');
    }
  }
}
