import 'package:cinneman/cubit/auth/auth_cubit.dart';
import 'package:cinneman/navigation/app_routes.dart';
import 'package:flutter/material.dart';

class AppRouteInformationParser extends RouteInformationParser<RoutePath> {
  final AuthCubit _authCubit;

  bool get isAuthenticated => _authCubit.state.isAuthenticated;

  AppRouteInformationParser({required AuthCubit authCubit})
      : _authCubit = authCubit;

  @override
  Future<RoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location ?? '');

    // Handle anonymous pages
    if (!isAuthenticated) {
      switch (uri.path) {
        case '/welcome':
          return RoutePath(route: AppRoutes.welcomeScreen);
        case '/login':
          return RoutePath(route: AppRoutes.login);
        case '/login/otp':
          return RoutePath(route: AppRoutes.otp);
        default:
          return RoutePath(route: AppRoutes.welcomeScreen);
      }
    }

    // Handle authenticated pages
    switch (uri.path) {
      case '/movies':
        return RoutePath(route: AppRoutes.moviesListPage);
      case '/movie-details':
        // Assuming movieId is a query parameter
        if (uri.queryParameters.containsKey('movieId')) {
          // Pass the movieId as an additional property to RoutePath if needed
          return RoutePath(
              route: AppRoutes.movieDetailsPage,
              args: uri.queryParameters['movieId']);
        }
        return RoutePath(route: AppRoutes.moviesListPage);
      case '/checkout':
        return RoutePath(route: AppRoutes.checkoutPage);
      case '/profile':
        return RoutePath(route: AppRoutes.userProfile);
      case '/tickets':
        return RoutePath(route: AppRoutes.userTickets);
      default:
        return RoutePath(route: AppRoutes.moviesListPage);
    }
  }

  @override
  RouteInformation? restoreRouteInformation(RoutePath path) {
    switch (path.route) {
      case AppRoutes.splash:
        return RouteInformation(location: '/');
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
        return null;
    }
  }
}
