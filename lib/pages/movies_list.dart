import 'package:cinneman/core/style/colors.dart';
import 'package:cinneman/core/style/images.dart';
import 'package:cinneman/cubit/navigation/navigation_cubit.dart';
import 'package:cinneman/data/models/fake_movies.dart';
import 'package:cinneman/features/home/presentation/widgets/moview_preview.dart';
import 'package:cinneman/navigation/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoviesListPage extends StatelessWidget {
  List<FakeMovies> fakeMovies = FakeUtils.getFakeMovies();
  @override
  Widget build(BuildContext context) {
    var navigationCubit = BlocProvider.of<NavigationCubit>(context);

    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => <Widget>[
                SliverAppBar(
                  backgroundColor: CustomColors.brown1,
                  elevation: 0.0,
                  title: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Movie menu:"),
                          GestureDetector(
                            onTap: () {
                              navigationCubit.push(
                                  RouteConfig(route: AppRoutes.userProfile));
                            },
                            child: Image.asset(
                              PngIcons.cinnemanIcon,
                              color: CustomColors.yellow1,
                              height: 40,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
          body: Container(
              color: CustomColors.white,
              child: Column(
                children: [
                  Expanded(
                      child: ListView.builder(
                          itemCount: fakeMovies.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                navigationCubit.push(RouteConfig(
                                    route: AppRoutes.movieDetailsPage));
                              },
                              child:
                                  MoviewPreview(fakeMovies: fakeMovies[index]),
                            );
                          }))
                ],
              ))),
    );
  }
}

class MyAppBar extends StatelessWidget {
  Color? color;
  String? title;
  MyAppBar({Key? key, this.color, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var navigationCubit = BlocProvider.of<NavigationCubit>(context);

    return AppBar(
      backgroundColor: color ?? CustomColors.brown1,
      elevation: 0.0,
      title: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title ?? ''),
              GestureDetector(
                onTap: () {
                  navigationCubit
                      .push(RouteConfig(route: AppRoutes.userProfile));
                },
                child: Image.asset(
                  PngIcons.cinnemanIcon,
                  color: CustomColors.white,
                  height: 50,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
