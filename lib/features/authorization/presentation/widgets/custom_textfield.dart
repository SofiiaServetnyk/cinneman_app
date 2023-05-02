import 'package:cinneman/core/style/colors.dart';
import 'package:cinneman/core/style/paddings_and_consts.dart';
import 'package:cinneman/core/style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {Key? key,
      this.focusBorder,
      this.style,
      this.maxLength,
      this.enabledBorder,
      this.hint,
      this.label,
      this.hintStyle,
      required this.keyboardType,
      this.cursorColor})
      : super(key: key);
  final String? hint;
  final String? label;
  final TextStyle? style;
  final TextInputType keyboardType;
  final Color? cursorColor;
  final Color? enabledBorder;
  final TextStyle? hintStyle;
  final int? maxLength;
  final Color? focusBorder;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
          minWidth: ButtonSize.minWidth, minHeight: ButtonSize.minHeight),
      child: TextFormField(
        style: (widget.style ?? nunito.black.w400.s16),
        maxLength: widget.maxLength,
        keyboardType: widget.keyboardType,
        inputFormatters: [
          if (widget.keyboardType == TextInputType.phone)
            FilteringTextInputFormatter.allow(RegExp(r'[0-9\+]+')),
        ],
        decoration: InputDecoration(
            hintText: widget.hint ?? '',
            hintStyle: widget.hintStyle ?? nunito.black.w400.s16,
            counter: const Offstage(),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: Paddings.horizontal20),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(CustomBorderRadius.br),
              borderSide: widget.focusBorder != null
                  ? BorderSide(color: widget.focusBorder!)
                  : BorderSide(color: CustomColors.white),
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: widget.focusBorder != null
                    ? BorderSide(color: widget.enabledBorder!)
                    : BorderSide(color: CustomColors.yellow1),
                borderRadius: BorderRadius.circular(CustomBorderRadius.br))),
        cursorColor: widget.cursorColor ?? CustomColors.black,
      ),
    );
  }
}
