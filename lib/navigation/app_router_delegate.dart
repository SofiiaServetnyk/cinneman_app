import 'package:cinneman/cubit/auth/auth_cubit.dart';
import 'package:cinneman/cubit/error_cubit.dart';
import 'package:cinneman/cubit/navigation/navigation_cubit.dart';
import 'package:cinneman/navigation/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CinnemanRouterDelegate extends RouterDelegate<RouteConfig>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<RouteConfig> {
  GlobalKey<NavigatorState> navigatorKey;

  final UserCubit _authCubit;
  final NavigationCubit _navigationCubit;
  final ErrorCubit _errorCubit;
  final PageGenerator _pageGenerator;

  CinnemanRouterDelegate(
      {required UserCubit authCubit,
      required NavigationCubit navigationCubit,
      required ErrorCubit errorCubit,
      required PageGenerator pageGenerator})
      : navigatorKey = GlobalKey<NavigatorState>(),
        _authCubit = authCubit,
        _navigationCubit = navigationCubit,
        _errorCubit = errorCubit,
        _pageGenerator = pageGenerator {
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
        .map((r) => _pageGenerator.createPage(r))
        .toList();

    // pages.add(MaterialPage(child: PaymentScreen()));

    return BlocListener<ErrorCubit, String?>(
      bloc: _errorCubit,
      listener: (context, error) {
        if (error != null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(error),
            duration: Duration(seconds: 3),
          ));
        } else {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        }
      },
      child: Navigator(
        key: navigatorKey,
        pages: pages,
        onPopPage: (route, result) {
          if (!route.didPop(result)) {
            return false;
          }

          _navigationCubit.pop();

          return true;
        },
      ),
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
