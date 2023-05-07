import 'package:cinneman/core/style/text_style.dart';
import 'package:flutter/material.dart';

import '../../../../core/style/paddings_and_consts.dart';

class SessionSelectionButton extends StatefulWidget {
  String sessionTime;
  SessionSelectionButton({Key? key, required this.sessionTime})
      : super(key: key);

  @override
  State<SessionSelectionButton> createState() => _SessionSelectionButtonState();
}

class _SessionSelectionButtonState extends State<SessionSelectionButton> {
  bool isTapped = false;

  void changeTapp() {
    setState(() {
      isTapped = !isTapped;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: changeTapp,
      child: Container(
        margin: const EdgeInsets.all(5),
        // height: 100,        padding: Paddings.all10,
        width: ButtonSize.sessionMinWidth,
        decoration: BoxDecoration(
            color: isTapped ? Colors.blue : Colors.green,
            borderRadius: BorderRadius.circular(CustomBorderRadius.br)),
        child: Center(
          child: Text(widget.sessionTime,
              textAlign: TextAlign.center, style: nunito.w500.s18.white),
        ),
      ),
    );
  }
}
