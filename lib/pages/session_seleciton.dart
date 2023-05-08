import 'package:cinneman/core/style/colors.dart';
import 'package:cinneman/core/style/images.dart';
import 'package:cinneman/core/style/paddings_and_consts.dart';
import 'package:cinneman/core/style/text_style.dart';
import 'package:cinneman/cubit/movies/movies_cubit.dart';
import 'package:cinneman/data/models/session_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SeatSelectionPage extends StatelessWidget {
  MovieSession session;

  SeatSelectionPage({Key? key, required this.session}) : super(key: key);

  final TransformationController _transformationController =
      TransformationController();

  Widget build(BuildContext context) {
    // Set initial scale value (e.g., 0.5 for half the size)
    double initialScale = 0.85;
    _transformationController.value = Matrix4.identity()..scale(initialScale);

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(5.0),
          child: AppBar(
            backgroundColor: CustomColors.white,
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: CustomColors.brown1,
              ),
              onPressed: () {
                // Handle back button press here
              },
            ),
          ),
        ),
        body: Stack(
          children: [
            Center(
              child: Image.asset(
                PngIcons.seatSelection,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              color: CustomColors.white.withOpacity(0.9),
              child: Padding(
                padding: Paddings.all15,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MovieBanner(),
                        ],
                      ),
                      SizedBox(
                        height: SizedBoxSize.sbs20,
                      ),
                      Container(
                        color: Color.fromRGBO(0, 0, 0, 0.25),
                        child: SizedBox(
                          height: 400,
                          child: InteractiveViewer(
                            constrained: false,
                            scaleEnabled: true,
                            boundaryMargin: EdgeInsets.all(double.infinity),
                            alignment: Alignment.topCenter,
                            transformationController: _transformationController,
                            minScale: 0.2,
                            maxScale: 4,
                            child: Column(
                                children: List.generate(
                                    session.room.rows.length,
                                    (index) => SeatGridRow(
                                          row: session.room.rows[index],
                                        ))),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }
}

class SeatGridRow extends StatelessWidget {
  SeatRow row;

  SeatGridRow({Key? key, required this.row}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        RowNumberContainer(numberOfRows: row.index),
        BlocBuilder<MoviesCubit, MoviesState>(builder: (context, state) {
          return Wrap(
            direction: Axis.horizontal,
            children: [
              ...List.generate(
                  row.seats.length,
                  (index) => SeatContainer(
                      index: index,
                      type: row.seats[index].type,
                      available: row.seats[index].isAvailable,
                      onTap: () {
                        if (row.seats[index].isAvailable ||
                            state.selectedSeats?.contains(row.seats[index]) ==
                                true) {
                          BlocProvider.of<MoviesCubit>(context)
                              .toggleSeat(row.seats[index]);
                        }
                      },
                      selected:
                          state.selectedSeats?.contains(row.seats[index]) ??
                              false))
            ],
          );
        })
      ],
    );
  }
}

class RowNumberContainer extends StatelessWidget {
  int numberOfRows;
  RowNumberContainer({Key? key, required this.numberOfRows}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: CustomColors.yellow17,
      ),
      child: Center(
          child: Text(this.numberOfRows.toString(), style: nunito.white.s12)),
    );
  }
}

class SeatContainer extends StatelessWidget {
  int index;
  SeatType type = SeatType.NORMAL;
  bool available;
  bool selected = false;
  Function()? onTap;

  SeatContainer(
      {Key? key,
      required this.index,
      required this.type,
      required this.available,
      this.onTap,
      bool? selected})
      : selected = selected ?? false,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    Color seatColor;
    switch (type) {
      case SeatType.VIP:
        seatColor = Colors.red;
        break;

      case SeatType.BETTER:
        seatColor = Colors.orange;
        break;

      default:
        seatColor = Colors.yellow;
    }

    if (selected) {
      seatColor = Colors.white;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38,
        margin: const EdgeInsets.all(5),
        child: Center(
            child: Wrap(
          alignment: WrapAlignment.center,
          direction: Axis.vertical,
          children: [
            Container(
              width: 38,
              decoration: BoxDecoration(
                color: seatColor.withOpacity(available ? 1 : 0.25),
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected ? Colors.blue : Colors.black,
                  width: selected ? 4.0 : 1.0,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(1),
                child: ClipOval(
                  child: Image.asset(
                    fit: BoxFit.contain,
                    PngIcons.betterSeat,
                    width: 25,
                  ),
                ),
              ),
            ),
            Container(
                width: 38,
                child: Center(
                    child: Text(
                  index.toString(),
                  style: nunito.s12,
                )))
          ],
        )),
      ),
    );
  }
}

class MovieBanner extends StatelessWidget {
  const MovieBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          height: 100,
          child: Row(
            children: [
              Padding(
                padding: Paddings.all10,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: CustomColors.brown1,
                      width: 2,
                    ),
                  ),
                  child: const CircleAvatar(
                    radius: 40,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Title really long for tests",
                      style: nunito.w500.s22,
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                    ),
                    Text("12 May, 12.05", style: nunito.s14),
                    Container(
                        decoration: BoxDecoration(
                            color: CustomColors.yellow17,
                            borderRadius:
                                BorderRadius.circular(CustomBorderRadius.br)),
                        child: Padding(
                          padding: Paddings.all5,
                          child: Text('120 min', style: nunito.s12.white),
                        ))
                  ],
                ),
              )
            ],
          )),
    );
  }
}
