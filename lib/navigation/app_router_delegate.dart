import 'package:cinneman/cubit/auth/auth_cubit.dart';
import 'package:cinneman/cubit/navigation/navigation_cubit.dart';
import 'package:cinneman/navigation/app_routes.dart';
import 'package:flutter/material.dart';

class CinnemanRouterDelegate extends RouterDelegate<RouteConfig>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<RouteConfig> {
  GlobalKey<NavigatorState> navigatorKey;

  final AuthCubit _authCubit;
  final NavigationCubit _navigationCubit;
  final PageFactory _pageFactory;

  CinnemanRouterDelegate(
      {required AuthCubit authCubit,
      required NavigationCubit navigationCubit,
      required PageFactory pageFactory})
      : navigatorKey = GlobalKey<NavigatorState>(),
        _authCubit = authCubit,
        _navigationCubit = navigationCubit,
        _pageFactory = pageFactory {
    _navigationCubit.stream.listen((_) {
      notifyListeners();
    });

    _authCubit.stream.listen((_) {
      notifyListeners();
    });
  }

  bool get isAuthenticated => _authCubit.state.isAuthenticated;

  @override
  Widget build(BuildContext context) {
    List<Page> pages = _navigationCubit.state.stack
        .map((r) => _pageFactory.createPage(r))
        .toList();

    // pages.add(MaterialPage(child: SeatSelectionPage()));

    return Navigator(
      key: navigatorKey,
      pages: pages,
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        _navigationCubit.pop();

        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(RouteConfig config) async {
    // Check if the requested page key requires authentication
    bool requiresAuth = [
      AppRoutes.moviesListPage,
      AppRoutes.movieDetailsPage,
      AppRoutes.checkoutPage,
      AppRoutes.userProfile,
      AppRoutes.userTickets,
    ].contains(config.route);

    if (requiresAuth && !isAuthenticated) {
      _navigationCubit.goToPage(RouteConfig(route: AppRoutes.login));
    } else {
      _navigationCubit.goToPage(config);
    }
  }
}
