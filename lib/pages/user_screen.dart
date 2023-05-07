import 'package:cinneman/core/style/colors.dart';
import 'package:cinneman/core/style/images.dart';
import 'package:cinneman/core/style/paddings_and_consts.dart';
import 'package:cinneman/core/style/text_style.dart';
import 'package:cinneman/features/authorization/presentation/customtext_button.dart';
import 'package:cinneman/pages/session_seleciton.dart';
import 'package:flutter/material.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(30.0),
        child: AppBar(
          elevation: 0.0,
          backgroundColor: CustomColors.white,
        ),
      ),
      backgroundColor: CustomColors.white,
      body: SafeArea(
        // child: TextButton(
        //   child: Text('Logout'),
        //   onPressed: () {
        //     BlocProvider.of<AuthCubit>(context).logoutUser();
        //     BlocProvider.of<NavigationCubit>(context).startAnonymous();
        //   },
        // ),
        child: Center(
            child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.black,
                      width: 2.0,
                    ),
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      PngIcons.userImage,
                      height: IconSize.smallIconSize,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: Paddings.all10,
              child: Text("+380633072269", style: nunito),
            ),
            Padding(
              padding: Paddings.all10,
              child: TicketContainer(),
            ),
            CustomTextButton(
                onPressed: () {}, child: Text("Log out", style: nunito)),
          ],
        )),
      ),
    );
  }
}

class TicketContainer extends StatelessWidget {
  const TicketContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      decoration: BoxDecoration(
          color: CustomColors.grey,
          borderRadius: BorderRadius.circular(CustomBorderRadius.br)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [MovieBanner()],
          ),
          Row(
            children: [
              Expanded(
                  child: Column(
                children: [Text("Row: \n99", style: nunito.s14)],
              )),
              Expanded(
                  child: Column(
                children: [Text("Seat: \n999", style: nunito.s14)],
              )),
              Expanded(
                  child: Column(
                children: [Text("Room: \nNew York", style: nunito.s14)],
              )),
              Expanded(
                  child: Column(
                children: [Text("Price: \n999", style: nunito.s14)],
              ))
            ],
          ),
          Padding(
            padding: Paddings.all15,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(width: 225, height: 225, color: Colors.black)
              ],
            ),
          )
        ],
      ),
    );
  }
}
