import 'package:cinneman/cubit/auth/auth_cubit.dart';
import 'package:cinneman/cubit/navigation/navigation_cubit.dart';
import 'package:cinneman/navigation/app_route_information_parser.dart';
import 'package:cinneman/navigation/app_router_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final AuthCubit authCubit = AuthCubit();
    final NavigationCubit navigationCubit = NavigationCubit();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => authCubit),
        BlocProvider(create: (_) => navigationCubit),
      ],
      child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          routerDelegate: AppRouterDelegate(
              authCubit: authCubit, navigationCubit: navigationCubit),
          routeInformationParser:
              AppRouteInformationParser(authCubit: authCubit)),
    );
  }
}
