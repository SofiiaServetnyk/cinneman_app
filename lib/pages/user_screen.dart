import 'package:cinneman/core/style/colors.dart';
import 'package:cinneman/core/style/images.dart';
import 'package:cinneman/core/style/paddings_and_consts.dart';
import 'package:cinneman/core/style/text_style.dart';
import 'package:cinneman/cubit/navigation/navigation_cubit.dart';
import 'package:cinneman/cubit/user/user_cubit.dart';
import 'package:cinneman/cubit/user/user_state.dart';
import 'package:cinneman/data/models/ticket.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'widgets/custom_text_button.dart';
import 'widgets/ticket_container.dart';

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
            List<Ticket> sortedTickets = (state.tickets ?? [])
              ..sort((a, b) => a.date.compareTo(b.date))
              ..where((ticket) {
                final ticketDate = ticket.date;
                final twoHoursAgo = DateTime.now().subtract(const Duration(hours: 2));

                return ticketDate.isAfter(twoHoursAgo);
              }).toList();

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
                    : const Text('You have no tickets'),
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


