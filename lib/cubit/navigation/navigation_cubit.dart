import 'dart:async';

import 'package:cinneman/cubit/navigation/navigation_state.dart';
import 'package:cinneman/cubit/user/user_cubit.dart';
import 'package:cinneman/data/models/movie_session_models.dart';
import 'package:cinneman/navigation/app_routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationCubit extends Cubit<NavigationState> {
  UserCubit userCubit;

  NavigationCubit(this.userCubit)
      : super(NavigationState(stack: [RouteConfig(route: AppRoutes.splash)])) {
    Future.delayed(const Duration(seconds: 2)).then((_) {
      if (userCubit.state.isAuthenticated) {
        startAuthenticated();
      } else {
        startUnauthorized();
      }
    });
  }

  void startUnauthorized() {
    goToPage(RouteConfig(route: AppRoutes.welcomeScreen));
  }

  void startAuthenticated() {
    goToPage(RouteConfig(route: AppRoutes.moviesListPage));
  }

  void openMovieDetailsPage(int id) {
    push(RouteConfig(route: AppRoutes.movieDetailsPage, args: id));
  }

  void openMovieSessionPage(MovieSession session) {
    push(RouteConfig(route: AppRoutes.seatSelectPage, args: session));
  }

  void openPaymentPage() {
    push(RouteConfig(route: AppRoutes.checkoutPage));
  }

  void openUserPageAfterSuccessfulPayment() {
    state.clearAndPush(RouteConfig(route: AppRoutes.moviesListPage));
    push(RouteConfig(route: AppRoutes.userProfile));
  }

  void push(RouteConfig routePath) {
    emit(state.push(routePath));
  }

  void pop() {
    emit(state.pop());
  }

  void goToPage(RouteConfig routePath) {
    emit(state.clearAndPush(routePath));
  }

}
