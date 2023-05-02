import 'package:cinneman/core/style/customtextbutton_style.dart';
import 'package:flutter/material.dart';

class CustomTextButton extends TextButton {
  CustomTextButton({
    super.key,
    required VoidCallback onPressed,
    required Widget child,
    ButtonStyle? style,
  }) : super(
          onPressed: onPressed,
          child: child,
          style: textButtonStyle,
        );
}
