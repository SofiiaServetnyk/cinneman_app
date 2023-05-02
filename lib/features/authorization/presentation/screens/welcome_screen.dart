import 'package:cinneman/core/style/colors.dart';
import 'package:cinneman/core/style/images.dart';
import 'package:cinneman/core/style/paddings_and_consts.dart';
import 'package:cinneman/core/style/text_style.dart';
import 'package:cinneman/features/authorization/presentation/custom_button.dart';
import 'package:cinneman/features/authorization/presentation/customtext_button.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColors.brown2,
        body: SafeArea(
          child: Padding(
            padding: Paddings.all24,
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(height: SizedBoxSize.sbs25),
                    Image.asset(
                      PngIcons.welcomeScreen,
                      height: IconSize.iconSize,
                    ),
                    const SizedBox(height: SizedBoxSize.sbs50),
                    Text('Welcome to CINNEMAN! 🎬',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: CustomColors.yellow1,
                          fontFamily: 'Morganite',
                          fontSize: 36,
                          letterSpacing: 1.2,
                        )),
                    const SizedBox(height: SizedBoxSize.sbs45),
                    Text(
                      textAlign: TextAlign.center,
                      "Log in to unlock the full taste of our cinema experience and become a gourmet, or continue as a guest for a quick bite.",
                      style: nunito.s16.white,
                    ),
                    const SizedBox(height: SizedBoxSize.sbs75),
                    CustomButton(
                        onPressed: () {},
                        child: Text('Log in, I am gourmet',
                            style: nunito.s18.white)),
                    const SizedBox(height: SizedBoxSize.sbs25),
                    CustomTextButton(
                        onPressed: () {},
                        child: Text('I am guest, just want a bite',
                            style: nunito.s18.yellow1)),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
