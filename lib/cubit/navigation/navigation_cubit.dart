import 'package:cinneman/cubit/navigation/navigation_state.dart';
import 'package:cinneman/navigation/app_routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit()
      : super(NavigationState(routePath: RoutePath(route: AppRoutes.splash)));

  void updateRoute(RoutePath routePath) {
    emit(NavigationState(routePath: routePath));
  }
}
