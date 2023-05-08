import 'package:cinneman/core/style/colors.dart';
import 'package:cinneman/core/style/images.dart';
import 'package:cinneman/core/style/text_style.dart';
import 'package:cinneman/cubit/movies/movies_cubit.dart';
import 'package:cinneman/cubit/navigation/navigation_cubit.dart';
import 'package:cinneman/features/home/presentation/widgets/moview_preview.dart';
import 'package:cinneman/navigation/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoviesListPage extends StatelessWidget {
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
                          Text("Movies menu:", style: nunito.white.s18),
                          GestureDetector(
                            onTap: () {
                              navigationCubit.push(
                                  RouteConfig(route: AppRoutes.userProfile));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: CustomColors.yellow1),
                              child: Image.asset(
                                PngIcons.cinnemanIcon,
                                color: CustomColors.white,
                                height: 30,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
          body: BlocBuilder<MoviesCubit, MoviesState>(
            builder: (context, state) {
              var movies = state.movies.values.toList();

              return Container(
                  color: CustomColors.white,
                  child: Column(
                    children: [
                      Expanded(
                          child: ListView.builder(
                              itemCount: movies.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    navigationCubit
                                        .openMovieDetailsPage(movies[index].id);
                                  },
                                  child: MoviePreview(movie: movies[index]),
                                );
                              }))
                    ],
                  ));
            },
          )),
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
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: CustomColors.yellow1),
                  child: Image.asset(
                    PngIcons.cinnemanIcon,
                    color: CustomColors.white,
                    height: 30,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
