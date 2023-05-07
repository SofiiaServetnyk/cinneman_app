import 'package:cinneman/core/style/colors.dart';
import 'package:cinneman/core/style/images.dart';
import 'package:cinneman/core/style/paddings_and_consts.dart';
import 'package:cinneman/core/style/text_style.dart';
import 'package:cinneman/data/models/fake_session.dart';
import 'package:flutter/material.dart';

class SeatSelectionPage extends StatefulWidget {
  MyRow myRow = MyRow();
  int? numberOfRows = 6;
  int? numberOfSeats;

  SeatSelectionPage({Key? key}) : super(key: key);

  @override
  State<SeatSelectionPage> createState() => _SeatSelectionPageState();
}

class _SeatSelectionPageState extends State<SeatSelectionPage> {
  int? numberOfSeats;

  @override
  void initState() {
    super.initState();
    numberOfSeats = widget.myRow.getNumberOfSeats();
  }

  Widget build(BuildContext context) {
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
                          height: 300,
                          child: InteractiveViewer(
                            constrained: false,
                            scaleEnabled: true,
                            boundaryMargin: EdgeInsets.all(double.infinity),
                            alignment: Alignment.center,
                            minScale: 0.2,
                            maxScale: 2,
                            child: Column(
                              children: [
                                SeatGrid(
                                  numberOfSeats: 16,
                                  numberOfRows: widget.numberOfRows!,
                                ),
                                SeatGrid(
                                  numberOfSeats: 16,
                                  numberOfRows: widget.numberOfRows!,
                                ),
                                SeatGrid(
                                  numberOfSeats: 16,
                                  numberOfRows: widget.numberOfRows!,
                                ),
                                SeatGrid(
                                  numberOfSeats: 16,
                                  numberOfRows: widget.numberOfRows!,
                                ),
                                SeatGrid(
                                  numberOfSeats: 16,
                                  numberOfRows: widget.numberOfRows!,
                                ),
                                SeatGrid(
                                  numberOfSeats: 16,
                                  numberOfRows: widget.numberOfRows!,
                                ),
                                SeatGrid(
                                  numberOfSeats: 16,
                                  numberOfRows: widget.numberOfRows!,
                                ),
                                SeatGrid(
                                  numberOfSeats: 16,
                                  numberOfRows: widget.numberOfRows!,
                                ),
                                SeatGrid(
                                  numberOfSeats: 16,
                                  numberOfRows: widget.numberOfRows!,
                                ),
                                SeatGrid(
                                  numberOfSeats: 16,
                                  numberOfRows: widget.numberOfRows!,
                                ),
                                SeatGrid(
                                  numberOfSeats: 16,
                                  numberOfRows: widget.numberOfRows!,
                                ),
                                SeatGrid(
                                  numberOfSeats: 16,
                                  numberOfRows: widget.numberOfRows!,
                                ),
                              ],
                            ),
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

class SeatGrid extends StatelessWidget {
  int numberOfRows;
  int numberOfSeats;

  SeatGrid({Key? key, required this.numberOfRows, required this.numberOfSeats})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        RowNumberContainer(numberOfRows: 7),
        Wrap(
          direction: Axis.horizontal,
          children: [
            ...List.generate(
                numberOfSeats,
                (index) => SeatContainer(
                      SeatType: 0,
                    ))
          ],
        )
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

class SeatContainer extends StatefulWidget {
  SeatContainer({Key? key, required this.SeatType}) : super(key: key);
  int SeatType;

  @override
  State<SeatContainer> createState() => _SeatContainerState();
}

class _SeatContainerState extends State<SeatContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 25,
      margin: const EdgeInsets.all(5),
      child: Center(
          child: Wrap(
        direction: Axis.vertical,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.yellow,
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.black,
                width: 1.0,
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
        ],
      )),
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
                    backgroundImage: AssetImage(PngIcons.helperPoster),
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
