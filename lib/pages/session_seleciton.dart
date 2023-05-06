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
                  child: SingleChildScrollView(
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
                        InteractiveViewer(
                          scaleEnabled: true,
                          boundaryMargin: EdgeInsets.all(double.infinity),
                          child: Center(
                              child: Column(
                            children: [
                              SeatGrid(
                                NumberOfSeats: 16,
                                NumberOfRows: widget.numberOfRows!,
                              ),
                            ],
                          )),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}

class SeatGrid extends StatelessWidget {
  int NumberOfRows;
  int NumberOfSeats;
  SeatGrid({Key? key, required this.NumberOfRows, required this.NumberOfSeats})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        RowNumberContainer(numberOfRows: 7),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...List.generate(
                  NumberOfSeats,
                  (index) => Center(
                          child: SeatContainer(
                        SeatType: 0,
                      )))
            ],
          ),
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
          child: Text(this.numberOfRows.toString(), style: nunito.black.s12)),
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
      height: 55,
      margin: EdgeInsets.all(5),
      child: Center(
          child: Column(
        children: [
          Text("1"),
          Image.asset(
            fit: BoxFit.contain,
            PngIcons.betterString,
            width: 30,
            height: 30,
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
                  child: CircleAvatar(
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
                            color: Colors.purple,
                            borderRadius: BorderRadius.circular()),
                        child: Text('120 min', style: nunito.s12))
                  ],
                ),
              )
            ],
          )),
    );
  }
}
