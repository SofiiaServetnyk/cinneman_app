import 'package:cinneman/core/style/colors.dart';
import 'package:cinneman/core/style/images.dart';
import 'package:cinneman/core/style/paddings_and_consts.dart';
import 'package:cinneman/data/models/fake_session.dart';
import 'package:flutter/material.dart';

class SeatSelectionPage extends StatefulWidget {
  MyRow myRow = MyRow();
  int? numberOfRows;
  String long =
      " quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt";

  SeatSelectionPage({Key? key}) : super(key: key);

  @override
  State<SeatSelectionPage> createState() => _SeatSelectionPageState();
}

class _SeatSelectionPageState extends State<SeatSelectionPage> {
  int? numberOfRows;
  @override
  @override
  void initState() {
    super.initState();
    numberOfRows = widget.myRow.getNumberOfRows();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(5.0),
          child: AppBar(
            backgroundColor: CustomColors.white,
            elevation: 0,
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
                padding: const EdgeInsets.all(18.0),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                height: 100,
                                width: 325,
                                color: Colors.purpleAccent,
                                child: Text("Just a placeholder!!!!"))
                          ],
                        ),
                        SizedBox(
                          height: SizedBoxSize.sbs20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [Text("widget.long")],
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(widget.long),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                ListView.builder(itemBuilder: itemBuilder)
                              ],
                            ),
                          ],
                        )
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
