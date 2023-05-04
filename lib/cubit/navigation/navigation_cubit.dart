import 'package:cinneman/cubit/auth/auth_cubit.dart';
import 'package:cinneman/cubit/navigation/navigation_state.dart';
import 'package:cinneman/navigation/app_routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationCubit extends Cubit<NavigationState> {
  AuthCubit authCubit;
  // NavigationCubit()
  //     : super(NavigationState(routePath: RoutePath(route: AppRoutes.splash)));

  NavigationCubit(this.authCubit)
      : super(
            NavigationState(routePaths: [RoutePath(route: AppRoutes.splash)])) {
    Future.delayed(Duration(seconds: 2)).then((_) {
      if (authCubit.state.isAuthenticated) {
        startAuthenticated();
      } else {
        startAnonymous();
      }
    });
  }

  void startAnonymous() {
    goToPage(RoutePath(route: AppRoutes.welcomeScreen));
  }

  void startAuthenticated() {
    goToPage(RoutePath(route: AppRoutes.moviesListPage));
  }

  void push(RoutePath routePath) {
    emit(state.push(routePath));
  }

  void pop() {
    emit(state.pop());
  }

  void goToPage(RoutePath routePath) {
    emit(state.clearAndPush(routePath));
  }
}
