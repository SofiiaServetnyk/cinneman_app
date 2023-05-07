import 'package:cinneman/cubit/auth/auth_cubit.dart';
import 'package:cinneman/cubit/movies/movies_cubit.dart';
import 'package:cinneman/cubit/navigation/navigation_cubit.dart';
import 'package:cinneman/navigation/app_router_delegate.dart';
import 'package:cinneman/navigation/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

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
    final AuthCubit authCubit = AuthCubit();
    final NavigationCubit navigationCubit = NavigationCubit(authCubit);
    final MoviesCubit moviesCubit = MoviesCubit(authCubit);

    authCubit.stream.listen((state) async {
      if (state.isAuthenticated) {
        await moviesCubit.loadMovies();
      }
    });

    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => authCubit),
          BlocProvider(create: (_) => navigationCubit),
          BlocProvider(create: (_) => moviesCubit),
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Cinneman',

          routerDelegate: CinnemanRouterDelegate(
              authCubit: authCubit,
              navigationCubit: navigationCubit,
              pageGenerator: PageGenerator()),
          //       routeInformationParser:
          //           AppRouteInformationParser(authCubit: authCubit)),
        ));
  }
}
