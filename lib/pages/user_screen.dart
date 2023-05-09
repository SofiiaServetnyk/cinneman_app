import 'package:cinneman/core/style/colors.dart';
import 'package:cinneman/core/style/images.dart';
import 'package:cinneman/core/style/paddings_and_consts.dart';
import 'package:cinneman/core/style/text_style.dart';
import 'package:cinneman/cubit/navigation/navigation_cubit.dart';
import 'package:cinneman/cubit/user/user_cubit.dart';
import 'package:cinneman/cubit/user/user_state.dart';
import 'package:cinneman/data/models/ticket.dart';
import 'package:cinneman/features/authorization/presentation/customtext_button.dart';
import 'package:cinneman/pages/seat_selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

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
            List<Ticket> sortedTickets = List.from(state.tickets ?? [])
              ..sort((a, b) => b.date.compareTo(a.date));

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
                  child: Text(
                      state is Authenticated ? state.phoneNumber! : 'Guest',
                      style: nunito),
                ),
                sortedTickets.isNotEmpty
                    ? Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: sortedTickets.length,
                          itemBuilder: (BuildContext context, int index) =>
                              Padding(
                            padding: Paddings.all10,
                            child: TicketContainer(
                              ticketId: sortedTickets[index].id,
                              date: sortedTickets[index].date,
                              image: sortedTickets[index].image,
                              title: sortedTickets[index].name,
                            ),
                          ),
                        ),
                      )
                    : Text('You have no tickets'),
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
  int ticketId;
  String title;

  DateTime date;
  String image;

  TicketContainer(
      {Key? key,
      required this.ticketId,
      required this.date,
      required this.image,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var qrContent = "movie/$ticketId";

    return Container(
      width: 350,
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
          Padding(
            padding: Paddings.all15,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: Paddings.all15,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: QrImage(
                          data: qrContent,
                          version: QrVersions.auto,
                          size: 225.0,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
