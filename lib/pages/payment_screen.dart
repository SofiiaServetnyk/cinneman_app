import 'package:cinneman/core/style/colors.dart';
import 'package:cinneman/core/style/images.dart';
import 'package:cinneman/core/style/paddings_and_consts.dart';
import 'package:cinneman/core/style/text_style.dart';
import 'package:cinneman/features/authorization/presentation/custom_button.dart';
import 'package:cinneman/features/authorization/presentation/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add your payment information: ", style: nunito.black.s22),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: CustomColors.white,
      body: SafeArea(
        child: Padding(
          padding: Paddings.all24,
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Image.asset(
                    PngIcons.paymentScreen,
                    height: IconSize.smallIconSize,
                  ),
                  const SizedBox(
                    height: SizedBoxSize.sbs25,
                  ),
                  Form(
                    child: Column(
                      children: [
                        CustomTextField(
                          prefixicon: Padding(
                            padding: Paddings.all5,
                            child: Image.asset(
                              height: ButtonSize.sessionMinHeight,
                              PngIcons.cardIcon,
                              fit: BoxFit.cover,
                            ),
                          ),
                          keyboardType: TextInputType.number,
                          hint: "Card number",
                          limitTextInput: 19,
                        ),
                        SizedBox(
                          height: SizedBoxSize.sbs10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CustomTextField(
                                prefixicon: Padding(
                                  padding: Paddings.all5,
                                  child: Image.asset(
                                    height: ButtonSize.sessionMinHeight,
                                    PngIcons.calendarIcon,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                keyboardType: TextInputType.number,
                                slashFormatter: true,
                                maxWidth: ButtonSize.paymentMaxWidth,
                                hint: "MM/YY",
                                limitTextInput: 5),
                            SizedBox(
                              height: SizedBoxSize.sbs15,
                            ),
                            CustomTextField(
                                prefixicon: Padding(
                                  padding: Paddings.all5,
                                  child: Image.asset(
                                    height: ButtonSize.sessionMinHeight,
                                    PngIcons.cvvIcon,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                keyboardType: TextInputType.number,
                                hint: "CVV",
                                maxWidth: ButtonSize.paymentMaxWidth,
                                limitTextInput: 3),
                          ],
                        ),
                        SizedBox(
                          height: SizedBoxSize.sbs30,
                        ),
                        CustomButton(
                            onPressed: () {}, child: Text('Delicious Payment'))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
