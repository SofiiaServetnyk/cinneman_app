import 'package:cinneman/core/style/colors.dart';
import 'package:cinneman/core/style/images.dart';
import 'package:cinneman/core/style/paddings_and_consts.dart';
import 'package:cinneman/core/style/text_style.dart';
import 'package:cinneman/features/authorization/presentation/customtext_button.dart';
import 'package:cinneman/features/authorization/presentation/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class PhoneNumber extends StatefulWidget {
  const PhoneNumber({Key? key}) : super(key: key);

  @override
  State<PhoneNumber> createState() => PhoneNumberState();
}

class PhoneNumberState extends State<PhoneNumber> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColors.brown2,
        body: SafeArea(
            child: Padding(
                padding: Paddings.all24,
                child: Center(
                    child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: SizedBoxSize.sbs25),
                      Image.asset(
                        PngIcons.phoneNumberScreen,
                        height: IconSize.iconSize,
                      ),
                      const SizedBox(height: SizedBoxSize.sbs25),
                      Text(
                        'Enter your phone number',
                        style: nunito.s24.white.w500,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: SizedBoxSize.sbs10),
                      Text('We will send you the OTP code',
                          textAlign: TextAlign.center,
                          style: nunito.w400.s14.white),
                      const SizedBox(height: SizedBoxSize.sbs75),
                      CustomTextField(
                        hint: 'Phone number',
                        hintStyle: nunito.yellow1.w500,
                        style: nunito.white.w500.s16,
                        keyboardType: TextInputType.phone,
                        cursorColor: CustomColors.white,
                        maxLength: 15,
                      ),
                      const SizedBox(height: SizedBoxSize.sbs100),
                      CustomTextButton(
                          onPressed: () {},
                          child: Text('Send', style: nunito.s18.yellow1))
                    ],
                  ),
                )))));
  }
}
