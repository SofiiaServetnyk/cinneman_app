import 'package:cinneman/core/style/colors.dart';
import 'package:cinneman/core/style/images.dart';
import 'package:cinneman/data/models/fake_movies.dart';
import 'package:cinneman/features/home/presentation/widgets/moview_preview.dart';
import 'package:cinneman/navigation/app_router_delegate.dart';
import 'package:cinneman/navigation/app_routes.dart';
import 'package:flutter/material.dart';

class MoviesListPage extends StatefulWidget {
  List<FakeMovies> fakeMovies = FakeUtils.getFakeMovies();
  @override
  State<MoviesListPage> createState() => _MoviesListPageState();
}

class _MoviesListPageState extends State<MoviesListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => <Widget>[
                SliverAppBar(
                  backgroundColor: CustomColors.brown1,
                  elevation: 0.0,
                  title: Image.asset(
                    PngIcons.cinnemanIcon,
                    color: CustomColors.yellow1,
                    height: 40,
                  ),
                ),
              ],
          body: Container(
              color: CustomColors.white,
              child: Column(
                children: [
                  Expanded(
                      child: ListView.builder(
                          itemCount: widget.fakeMovies.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () async {
                                var delegate = Router.of(context).routerDelegate
                                    as AppRouterDelegate;

                                await delegate.setNewRoutePath(RoutePath(
                                    route: AppRoutes.movieDetailsPage));
                              },
                              child: MoviewPreview(
                                  fakeMovies: widget.fakeMovies[index]),
                            );
                          }))
                ],
              ))),
    );
  }
}
