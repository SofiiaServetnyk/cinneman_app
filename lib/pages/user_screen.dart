import 'package:cinneman/core/style/colors.dart';
import 'package:cinneman/core/style/images.dart';
import 'package:cinneman/core/style/paddings_and_consts.dart';
import 'package:cinneman/core/style/text_style.dart';
import 'package:cinneman/cubit/auth/auth_cubit.dart';
import 'package:cinneman/cubit/auth/auth_state.dart';
import 'package:cinneman/cubit/navigation/navigation_cubit.dart';
import 'package:cinneman/features/authorization/presentation/customtext_button.dart';
import 'package:cinneman/pages/seat_selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

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
        child: Center(child: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            return Column(
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
                state.tickets?.isNotEmpty == true
                    ? Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.tickets?.length ?? 0,
                        itemBuilder: (BuildContext context, int index) =>
                            Padding(
                          padding: Paddings.all10,
                          child: TicketContainer(
                            date: state.tickets![index].date,
                            image: state.tickets![index].image,
                            title: state.tickets![index].image,
                          ),
                        ),
                      ),
                    )
                    : Text('no tickets'),
                CustomTextButton(
                    onPressed: () {
                      BlocProvider.of<UserCubit>(context).logoutUser();
                      BlocProvider.of<NavigationCubit>(context)
                          .startUnauthorized();
                    },
                    child: Text("Log out", style: nunito)),
              ],
            );
          },
        )),
      ),
    );
  }
}

class TicketContainer extends StatelessWidget {
  String title;

  DateTime date;
  String image;

  TicketContainer(
      {Key? key, required this.date, required this.image, required this.title})
      : super(key: key);

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
            children: [
              MovieBanner(
                title: title,
                date: DateFormat("d MMMM, HH:mm").format(date),
                imageSrc: image,
              )
            ],
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
