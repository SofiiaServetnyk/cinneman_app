import 'package:cinneman/core/style/colors.dart';
import 'package:cinneman/features/authorization/presentation/widgets/splashscreen_icon.dart';
import 'package:cinneman/features/authorization/presentation/widgets/splashscreen_text.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            SplashScreenIcon(),
            SplashScreenText(),
          ],
        ),
      ),
    );
  }
}
