import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'profile_state.dart';
import '../../shared/user_data_header.dart';
import '../../shared/main_card.dart';
import '../../../../controllers/auth.dart';
import '../../../../core/utilities/size_config.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return MainCard(
        width: SizeConfig.screenWidth!,
        padding: const EdgeInsets.only(bottom: 0, right: 7, left: 7),
        child: Column(
          children: [
            const UserDataHeader(),
            if (context.watch<Auth>().isAuth) const ProfileState(),
          ],
        ));
  }
}
