import 'package:cinneman/core/style/colors.dart';
import 'package:cinneman/core/style/images.dart';
import 'package:cinneman/core/style/paddings_and_consts.dart';
import 'package:cinneman/core/style/text_style.dart';
import 'package:cinneman/cubit/auth/auth_cubit.dart';
import 'package:cinneman/cubit/navigation/navigation_cubit.dart';
import 'package:cinneman/features/authorization/presentation/customtext_button.dart';
import 'package:cinneman/features/authorization/presentation/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtpPage extends StatelessWidget {
  const OtpPage({Key? key}) : super(key: key);

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
                          PngIcons.otpScreen,
                          height: IconSize.bigIconSize,
                        ),
                        const SizedBox(height: SizedBoxSize.sbs25),
                        Text(
                          'Enter the OTP code',
                          style: nunito.s24.white.w500,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: SizedBoxSize.sbs10),
                        Text('Enter 4-digit code sent yo your mobile number',
                            textAlign: TextAlign.center,
                            style: nunito.w400.s14.white),
                        const SizedBox(height: SizedBoxSize.sbs75),
                        CustomTextField(
                          hint: '4-digit code',
                          hintStyle: nunito.yellow1.w500,
                          style: nunito.white.w500.s16,
                          keyboardType: TextInputType.number,
                          cursorColor: CustomColors.white,
                          maxLength: 4,
                        ),
                        const SizedBox(height: SizedBoxSize.sbs100),
                        CustomTextButton(
                            onPressed: () {
                              BlocProvider.of<AuthCubit>(context).loginUser();
                              BlocProvider.of<NavigationCubit>(context)
                                  .startAuthenticated();
                            },
                            child: Text('Send', style: nunito.s18.yellow1))
                      ],
                    ),
                  ),
                ))));
  }
}
