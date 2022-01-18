import 'package:flutter/material.dart';
import 'package:new_turki/models/user_data.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:new_turki/widgets/shared/main_card.dart';
import 'package:new_turki/widgets/shared/user_data_header.dart';
import 'profile_state.dart';

class ProfileHeader extends StatelessWidget {
  final bool isAuth;
  final UserData userData;
  final int ordersCount;

  const ProfileHeader(
      {required this.isAuth,
      required this.userData,
      required this.ordersCount});
  @override
  Widget build(BuildContext context) {
    return MainCard(
        width: SizeConfig.screenWidth!,
        padding: EdgeInsets.only(bottom: 0, right: 7, left: 7),
        child: Column(
          children: [
            UserDataHeader(),
            if (isAuth) ProfileState(user: userData, orders: ordersCount),
          ],
        ));
  }
}
