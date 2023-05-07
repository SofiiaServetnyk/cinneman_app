import 'package:cinneman/core/style/colors.dart';
import 'package:cinneman/core/style/paddings_and_consts.dart';
import 'package:cinneman/core/style/text_style.dart';
import 'package:cinneman/cubit/movies/movies_cubit.dart';
import 'package:cinneman/features/authorization/presentation/custom_button.dart';
import 'package:cinneman/features/home/presentation/widgets/custom_calendar.dart';
import 'package:cinneman/features/home/presentation/widgets/movie_detail_row.dart';
import 'package:cinneman/pages/movies_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieDetailsPage extends StatelessWidget {
  int movieId;

  MovieDetailsPage({Key? key, required this.movieId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesCubit, MoviesState>(
      builder: (context, state) {
        var movie = state.movies[movieId]!;

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
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(movie.image),
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
                              Text(movie.name, style: nunito.white.w800.s24),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(movie.year.toString(),
                                      style: nunito.white),
                                  const SizedBox(height: SizedBoxSize.sbs10),
                                  Container(
                                      padding: Paddings.all10,
                                      decoration: BoxDecoration(
                                          color: CustomColors.yellow1,
                                          borderRadius: BorderRadius.circular(
                                              CustomBorderRadius.br)),
                                      child: Text(
                                          movie.duration.toString() + ' min',
                                          style: nunito.white)),
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
                          child: IntrinsicHeight(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                MovieDetailRow(
                                    title: 'Genre', description: movie.genre),
                                MovieDetailRow(
                                    title: 'Plot', description: movie.plot),
                                MovieDetailRow(
                                    title: 'Starring',
                                    description: movie.starring),
                                MovieDetailRow(
                                    title: 'Language',
                                    description: movie.language),
                                MovieDetailRow(
                                    title: 'Country',
                                    description: movie.country),
                                MovieDetailRow(
                                    title: 'Director',
                                    description: movie.director),
                                MovieDetailRow(
                                    title: 'Screenwriter',
                                    description: movie.screenwriter),
                                MovieDetailRow(
                                    title: 'Studio', description: movie.studio),
                              ],
                            ),
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
      },
    );
  }
}
