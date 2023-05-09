import 'package:cinneman/cubit/auth/auth_cubit.dart';
import 'package:cinneman/cubit/error_cubit.dart';
import 'package:cinneman/cubit/movies/movies_cubit.dart';
import 'package:cinneman/cubit/navigation/navigation_cubit.dart';
import 'package:cinneman/navigation/app_router_delegate.dart';
import 'package:cinneman/navigation/app_routes.dart';
import 'package:cinneman/services/movies_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  await dotenv.load();

  runApp(const MyApp());
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final UserCubit authCubit = UserCubit();
    final NavigationCubit navigationCubit = NavigationCubit(authCubit);
    final MoviesCubit moviesCubit = MoviesCubit(authCubit);
    final ErrorCubit errorCubit = ErrorCubit();

    authCubit.stream.listen((state) async {
      if (state.isAuthenticated) {
        try {
          await moviesCubit.loadMovies();
        } catch (e) {
          errorCubit.showError('Failed to load movies.');
        }
      }
    });

    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => authCubit),
          BlocProvider(create: (_) => navigationCubit),
          BlocProvider(create: (_) => moviesCubit),
          BlocProvider(create: (_) => errorCubit),
          Provider<MovieService>(create: (_) => MovieService(authCubit)),
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Cinneman',
          routerDelegate: CinnemanRouterDelegate(
              authCubit: authCubit,
              navigationCubit: navigationCubit,
              errorCubit: errorCubit,
              pageGenerator: PageGenerator()),
        ));
  }
}
