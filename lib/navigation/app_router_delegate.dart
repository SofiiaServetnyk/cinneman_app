import 'package:cinneman/cubit/auth/auth_cubit.dart';
import 'package:cinneman/cubit/navigation/navigation_cubit.dart';
import 'package:cinneman/navigation/app_routes.dart';
import 'package:cinneman/pages/login_screen.dart';
import 'package:cinneman/pages/movie_details.dart';
import 'package:cinneman/pages/movies_list.dart';
import 'package:cinneman/pages/otp_screen.dart';
import 'package:cinneman/pages/splash_screen.dart';
import 'package:cinneman/pages/welcome_screen.dart';
import 'package:flutter/material.dart';

class AppRouterDelegate extends RouterDelegate<RoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<RoutePath> {
  final GlobalKey<NavigatorState> navigatorKey;

  bool _showSplashScreen = true;

  final AuthCubit _authCubit;
  final NavigationCubit _navigationCubit;

  // RoutePath _currentConfiguration = RoutePath(route: AppRoutes.splash);

  AppRouterDelegate(
      {required AuthCubit authCubit, required NavigationCubit navigationCubit})
      : navigatorKey = GlobalKey<NavigatorState>(),
        _authCubit = authCubit,
        _navigationCubit = navigationCubit {
    _navigationCubit.stream.listen((_) {
      notifyListeners();
    });

    _authCubit.stream.listen((_) {
      notifyListeners();
    });
  }

  RoutePath get currentConfiguration => _navigationCubit.state.routePath;

  bool get isAuthenticated => _authCubit.state.isAuthenticated;

  set currentConfiguration(RoutePath value) {
    _navigationCubit.updateRoute(value);
  }

  @override
  Widget build(BuildContext context) {
    if (_showSplashScreen) {
      Future.delayed(const Duration(seconds: 0)).then((_) {
        _showSplashScreen = false;
        notifyListeners();
      });

      return const SplashScreen();
    }

    // Build list of pages based on authentication state
    List<Page> pages =
        isAuthenticated ? _buildAuthenticatedPages() : _buildAnonymousPages();

    pages.add(MaterialPage(child: MovieDetailsPage()));

    return Navigator(
      key: navigatorKey,
      pages: pages,
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        switch (currentConfiguration.route) {
          case AppRoutes.checkoutPage:
            currentConfiguration = RoutePath(
                route: AppRoutes.seatSelectPage,
                args: currentConfiguration.args);
            break;

          case AppRoutes.seatSelectPage:
            currentConfiguration = RoutePath(
                route: AppRoutes.movieDetailsPage,
                args: currentConfiguration.args);
            break;

          case AppRoutes.movieDetailsPage:
            currentConfiguration = RoutePath(route: AppRoutes.moviesListPage);
            break;
        }

        notifyListeners();

        return true;
      },
    );
  }

  List<Page> _buildAnonymousPages() {
    // Return a list of MaterialPage objects for anonymous pages
    return [
      if (currentConfiguration.route == AppRoutes.welcomeScreen)
        MaterialPage(
            child: WelcomePage(), key: ValueKey(AppRoutes.welcomeScreen)),
      if (currentConfiguration.route == AppRoutes.login)
        MaterialPage(child: LoginPage(), key: ValueKey(AppRoutes.login)),
      if (currentConfiguration.route == AppRoutes.otp)
        MaterialPage(child: OtpPage(), key: ValueKey(AppRoutes.otp)),
    ];
  }

  List<Page> _buildAuthenticatedPages() {
    // Return a list of MaterialPage objects for authenticated pages
    var pages = [
      MaterialPage(
          child: MoviesListPage(), key: ValueKey(AppRoutes.moviesListPage))
    ];

    if (currentConfiguration.route == AppRoutes.movieDetailsPage) {
      pages.add(MaterialPage(
          child: MovieDetailsPage(),
          key: ValueKey(AppRoutes.movieDetailsPage)));
    }

    // if (currentConfiguration.route == AppRoutes.checkout)
    //   MaterialPage(child: CheckoutPage(), key: ValueKey(AppRoutes.checkout)),
    // if (currentConfiguration.route == AppRoutes.userProfile)
    //   MaterialPage(
    //       child: UserProfilePage(), key: ValueKey(AppRoutes.userProfile)),
    // if (currentConfiguration.route == AppRoutes.userTickets)
    //   MaterialPage(
    //       child: UserTicketsPage(), key: ValueKey(AppRoutes.userTickets)),

    return pages;
  }

  @override
  Future<void> setNewRoutePath(RoutePath path) async {
    // Check if the requested page key requires authentication
    bool requiresAuth = [
      AppRoutes.moviesListPage,
      AppRoutes.movieDetailsPage,
      AppRoutes.checkoutPage,
      AppRoutes.userProfile,
      AppRoutes.userTickets,
    ].contains(path.route);

    if (requiresAuth && !isAuthenticated) {
      // If the user is not authenticated, redirect them to the login page
      currentConfiguration = RoutePath(route: AppRoutes.login);
    } else {
      // Otherwise, update the current configuration with the new route path
      currentConfiguration = path;
    }
  }
}
