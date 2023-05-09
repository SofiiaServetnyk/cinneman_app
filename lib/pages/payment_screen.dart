import 'package:cinneman/core/style/colors.dart';
import 'package:cinneman/core/style/images.dart';
import 'package:cinneman/core/style/paddings_and_consts.dart';
import 'package:cinneman/core/style/text_style.dart';
import 'package:cinneman/cubit/error_cubit.dart';
import 'package:cinneman/cubit/movies/movies_cubit.dart';
import 'package:cinneman/cubit/navigation/navigation_cubit.dart';
import 'package:cinneman/features/authorization/presentation/custom_button.dart';
import 'package:cinneman/features/authorization/presentation/widgets/custom_textfield.dart';
import 'package:cinneman/services/movies_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String? cardNumber;
  String? expirationDate;
  String? cvv;
  String? email;

  Future<void> _handlePayment() async {
    var errorCubit = BlocProvider.of<ErrorCubit>(context);
    if (cardNumber == null ||
        expirationDate == null ||
        cvv == null ||
        email == null) {
      throw MoviesServiceException("Please fill in all the fields.");
      // errorCubit.showError("Please fill in all the fields.");
    } else {
      final RegExp cardNumberRegExp = RegExp(
          r"^(?:4[0-9]{12}(?:[0-9]{3})?|5[1-5][0-9]{14}|6011[0-9]{12}|622((12[6-9]|1[3-9][0-9]|[2-8][0-9][0-9]|9[01][0-9]|92[0-5])[0-9]{10})|64[4-9][0-9]{13}|65[0-9]{14}|3(?:0[0-5]|[68][0-9])[0-9]{11}|3[47][0-9]{13})$");
      final RegExp expirationDateRegExp =
          RegExp(r"^(0[1-9]|1[0-2])\/?([0-9]{4}|[0-9]{2})$");
      final RegExp cvvRegExp = RegExp(r"^[0-9]{3}$");

      // Remove spaces from card number
      String cleanedCardNumber =
          cardNumber!.replaceAll(RegExp(r"\s+\b|\b\s"), "");

      if (!cardNumberRegExp.hasMatch(cleanedCardNumber)) {
        // errorCubit.showError("Invalid card number.");
        throw MoviesServiceException("Invalid card number");
      } else if (!expirationDateRegExp.hasMatch(expirationDate!)) {
        // errorCubit
        //     .showError("Invalid expiration date. Format should be MM/YY.");
        throw MoviesServiceException(
            "Invalid expiration date. Format should be MM/YY.");
      } else if (!cvvRegExp.hasMatch(cvv!)) {
        // errorCubit.showError("Invalid CVV. It should be a 3-digit number.");
        throw MoviesServiceException(
            "Invalid CVV. It should be a 3-digit number");
      } else {
        var moviesCubit = BlocProvider.of<MoviesCubit>(context);

        final session = moviesCubit.state.movieSession;
        final seats = moviesCubit.state.selectedSeats;
        if (session == null || seats == null) {
          // errorCubit.showError("Please select a session and seats.");
          throw MoviesServiceException("Please select a session and seats");
        } else {
          await moviesCubit.buyTickets(
            seats: seats.toList(),
            session: session,
            email: email!,
            cardNumber: cleanedCardNumber,
            expirationDate: expirationDate!,
            cvv: cvv!,
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: CustomColors.brown1),
        title: Text("Add your payment information: ", style: nunito.black.s20),
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
                          onChanged: (value) =>
                              setState(() => cardNumber = value),
                          prefixIcon: Padding(
                            padding: Paddings.all5,
                            child: Image.asset(
                              height: ButtonSize.sessionMinHeight,
                              PngIcons.cardIcon,
                              fit: BoxFit.cover,
                            ),
                          ),
                          keyboardType: TextInputType.number,
                          hint: "Card number",
                          formatter: "space",
                          enabledBorder: CustomColors.grey,
                          focusBorder: CustomColors.brown1,
                          limitTextInput: 19,
                        ),
                        const SizedBox(
                          height: SizedBoxSize.sbs10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CustomTextField(
                                onChanged: (value) =>
                                    setState(() => expirationDate = value),
                                prefixIcon: Padding(
                                  padding: Paddings.all5,
                                  child: Image.asset(
                                    height: ButtonSize.sessionMinHeight,
                                    PngIcons.calendarIcon,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                keyboardType: TextInputType.number,
                                formatter: "slash",
                                enabledBorder: CustomColors.grey,
                                focusBorder: CustomColors.brown1,
                                maxWidth: ButtonSize.paymentMaxWidth,
                                hint: "MM/YY",
                                limitTextInput: 5),
                            const SizedBox(
                              height: SizedBoxSize.sbs15,
                            ),
                            CustomTextField(
                                onChanged: (value) =>
                                    setState(() => cvv = value),
                                prefixIcon: Padding(
                                  padding: Paddings.all5,
                                  child: Image.asset(
                                    height: ButtonSize.sessionMinHeight,
                                    PngIcons.cvvIcon,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                keyboardType: TextInputType.number,
                                hint: "CVV",
                                enabledBorder: CustomColors.grey,
                                focusBorder: CustomColors.brown1,
                                maxWidth: ButtonSize.paymentMaxWidth,
                                limitTextInput: 3),
                          ],
                        ),
                        const SizedBox(
                          height: SizedBoxSize.sbs10,
                        ),
                        CustomTextField(
                            onChanged: (value) => setState(() => email = value),
                            prefixIcon: Padding(
                              padding: Paddings.all5,
                              child: SizedBox(
                                height: 15,
                                width: 15,
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Image.asset(
                                    PngIcons.emailIcon,
                                    // fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            hint: "Email",
                            enabledBorder: CustomColors.grey,
                            focusBorder: CustomColors.brown1,
                            keyboardType: TextInputType.emailAddress),
                        const SizedBox(
                          height: SizedBoxSize.sbs30,
                        ),
                        CustomButton(
                            onPressed: () async {
                              try {
                                await _handlePayment();
                              } catch (e) {
                                if (e is MoviesServiceException) {
                                  BlocProvider.of<ErrorCubit>(context)
                                      .showError(e.message);

                                  return;
                                } else {
                                  throw e;
                                }
                              }

                              if (BlocProvider.of<MoviesCubit>(context).state
                                  is SuccessfulPaymentMovieState) {
                                BlocProvider.of<NavigationCubit>(context)
                                    .openUserPageAfterSuccesfulPayment();
                              } else {
                                BlocProvider.of<ErrorCubit>(context)
                                    .showError("Could not process payment");
                              }
                            },
                            child: Text(
                              'Delicious Payment',
                              style: nunito.white,
                            ))
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
