import 'package:flutter/material.dart';
import '../../../core/utilities/size_config.dart';
import '../../widgets/shared/main_card.dart';
import '../shared/user_data_header.dart';
import 'profile_state.dart';

class ProfileHeader extends StatelessWidget {
  final bool isAuth;

  const ProfileHeader({
    Key? key,
    required this.isAuth,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MainCard(
        width: SizeConfig.screenWidth!,
        padding: const EdgeInsets.only(bottom: 0, right: 7, left: 7),
        child: Column(
          children: [
            const UserDataHeader(),
            if (isAuth) const ProfileState(),
          ],
        ));
  }
}