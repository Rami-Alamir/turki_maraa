import 'package:flutter/material.dart';
import 'package:new_turki/models/user.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:new_turki/widgets/shared/main_card.dart';
import 'package:new_turki/widgets/shared/user_data_header.dart';
import 'profile_state.dart';

class ProfileHeader extends StatelessWidget {
  final User user;
  final bool isAuth;

  const ProfileHeader({required this.user, required this.isAuth});
  @override
  Widget build(BuildContext context) {
    print(isAuth.toString());
    return MainCard(
        width: SizeConfig.screenWidth!,
        padding: EdgeInsets.only(bottom: 0, right: 7, left: 7),
        child: Column(
          children: [
            UserDataHeader(
              user: user,
              isAuth: isAuth,
            ),
            Visibility(
              visible: isAuth,
              child: ProfileState(
                user: user,
              ),
            ),
          ],
        ));
  }
}
