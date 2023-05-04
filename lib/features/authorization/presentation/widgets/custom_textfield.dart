import 'package:cinneman/core/style/colors.dart';
import 'package:cinneman/core/style/paddings_and_consts.dart';
import 'package:cinneman/core/style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  CustomTextField(
      {Key? key,
      this.limitTextInput,
      this.focusBorder,
      this.prefixicon,
      this.style,
      this.maxLength,
      this.enabledBorder,
      this.maxWidth,
      this.hint,
      this.slashFormatter,
      this.label,
      this.hintStyle,
      this.fillColor,
      required this.keyboardType,
      this.cursorColor})
      : super(key: key);
  final String? hint;
  final String? label;
  final int? limitTextInput;
  final TextStyle? style;
  final TextInputType keyboardType;
  final Color? cursorColor;
  final Color? enabledBorder;
  final TextStyle? hintStyle;
  final int? maxLength;
  final Color? fillColor;
  final Color? focusBorder;
  final double? maxWidth;
  final Widget? prefixicon;
  bool? slashFormatter = false;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
          maxWidth: widget.maxWidth ?? ButtonSize.minWidth,
          minHeight: ButtonSize.minHeight),
      child: TextFormField(
        style: (widget.style ?? nunito.black.w400.s16),
        maxLength: widget.maxLength,
        keyboardType: widget.keyboardType,
        inputFormatters: [
          if (widget.keyboardType == TextInputType.phone)
            FilteringTextInputFormatter.allow(RegExp(r'[0-9\+]+'))
          else if (widget.keyboardType == TextInputType.number)
            FilteringTextInputFormatter.allow(RegExp(r'[0-9\+]+')),
          widget.slashFormatter == null
              ? CardNumberInputFormatter()
              : CardMonthInputFormatter(),
          LengthLimitingTextInputFormatter(widget.limitTextInput ?? null),
        ],
        decoration: InputDecoration(
            prefixIcon: widget.prefixicon ?? null,
            filled: true,
            fillColor: widget.fillColor ?? CustomColors.grey,
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

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) return newValue;

    String inputData = newValue.text;
    StringBuffer buffer = StringBuffer();

    for (var i = 0; i < inputData.length; i++) {
      buffer.write(inputData[i]);
      int index = i + 1;

      if (index % 4 == 0 && inputData.length != index) {
        buffer.write(' ');
      }
      ;
    }
    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(
        offset: buffer.toString().length,
      ),
    );
  }
}

class CardMonthInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) return newValue;

    String inputData = newValue.text;
    StringBuffer buffer = StringBuffer();

    for (var i = 0; i < inputData.length; i++) {
      buffer.write(inputData[i]);
      int index = i + 1;

      if (index % 2 == 0 && inputData.length != index) {
        buffer.write('/');
      }
      ;
    }
    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(
        offset: buffer.toString().length,
      ),
    );
  }
}
