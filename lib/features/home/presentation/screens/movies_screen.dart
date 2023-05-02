import 'package:cinneman/core/style/colors.dart';
import 'package:cinneman/core/style/images.dart';
import 'package:cinneman/data/models/fake_movies.dart';
import 'package:cinneman/features/home/presentation/widgets/moview_preview.dart';
import 'package:flutter/material.dart';

class Helper extends StatefulWidget {
  Helper({Key? key}) : super(key: key);
  List<FakeMovies> fakeMovies = FakeUtils.getFakeMovies();
  @override
  State<Helper> createState() => _HelperState();
}

class _HelperState extends State<Helper> {
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
                            return MoviewPreview(
                                fakeMovies: widget.fakeMovies[index]);
                          }))
                ],
              ))),
    );
  }
}
