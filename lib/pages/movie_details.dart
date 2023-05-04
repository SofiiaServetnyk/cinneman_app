import 'package:cinneman/core/style/colors.dart';
import 'package:cinneman/core/style/images.dart';
import 'package:cinneman/core/style/paddings_and_consts.dart';
import 'package:cinneman/core/style/text_style.dart';
import 'package:cinneman/data/models/fake_movies.dart';
import 'package:cinneman/features/authorization/presentation/custom_button.dart';
import 'package:cinneman/features/home/presentation/widgets/custom_calendar.dart';
import 'package:cinneman/features/home/presentation/widgets/movie_detail_row.dart';
import 'package:cinneman/pages/movies_list.dart';
import 'package:flutter/material.dart';

class MovieDetailsPage extends StatefulWidget {
  List<FakeMovies> fakeMovies = FakeUtils.getFakeMovies();

  MovieDetailsPage({Key? key}) : super(key: key);

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.white,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(CustomBorderRadius.br),
              ),
              child: Stack(
                children: [
                  Container(
                    height: 300,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(PngIcons.helperPoster),
                            fit: BoxFit.cover)),
                  ),
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                            CustomColors.brown1,
                            Colors.transparent
                          ])),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: Paddings.all10,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Film name', style: nunito.white.w800.s24),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text('Some text'),
                              const SizedBox(height: SizedBoxSize.sbs10),
                              Container(
                                  padding: Paddings.all10,
                                  decoration: BoxDecoration(
                                      color: CustomColors.yellow1,
                                      borderRadius: BorderRadius.circular(
                                          CustomBorderRadius.br)),
                                  child: const Text('Some info'))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  MyAppBar(color: Colors.transparent),
                ],
              ),
            ),
            Expanded(
                child: Padding(
              padding: Paddings.all20,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          MovieDetailRow(
                              title: 'Cameramen', description: 'Супер класний'),
                          MovieDetailRow(
                              title: 'Cameramen', description: 'Супер класний'),
                          MovieDetailRow(
                              title: 'Cameramen', description: 'Супер класний'),
                          MovieDetailRow(
                              title: 'Cameramen', description: 'Супер класний'),
                          MovieDetailRow(
                              title: 'Cameramen', description: 'Супер класний'),
                          MovieDetailRow(
                              title: 'Cameramen', description: 'Супер класний'),
                          MovieDetailRow(
                              title: 'Cameramen', description: 'Супер класний'),
                          MovieDetailRow(
                              title: 'Cameramen', description: 'Супер класний'),
                          MovieDetailRow(
                              title: 'director', description: 'Соня Шник'),
                          MovieDetailRow(
                              title: 'Cameramen', description: 'Супер класний'),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: 20,
                      left: 0,
                      right: 0,
                      child: CustomButton(
                          onPressed: () => showModalBottomSheet(
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(
                                          CustomBorderRadius.br))),
                              context: context,
                              builder: (context) => CustomCalendar()),
                          child: const Text('Delicious tickets')))
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
