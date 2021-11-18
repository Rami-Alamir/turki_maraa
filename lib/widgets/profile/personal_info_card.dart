import 'package:flutter/material.dart';
import 'package:new_turki/utilities/ra7_icons.dart';
import 'package:new_turki/widgets/shared/main_card.dart';
import 'profile_row.dart';

class PersonalInfoCard extends StatelessWidget {
  final bool isAuth;

  const PersonalInfoCard({required this.isAuth});
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isAuth,
      child: MainCard(
          padding: EdgeInsets.only(bottom: 1, right: 7, left: 7),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              children: [
                ProfileRow(
                    onTap: () =>
                        Navigator.pushNamed(context, '/PersonalInformation'),
                    icon: RA7ICONS.user,
                    title: 'personal_information'),
                ProfileRow(
                    onTap: () => Navigator.pushNamed(context, '/Favourite'),
                    icon: RA7ICONS.heart,
                    withDivider: false,
                    title: 'favorite'),
              ],
            ),
          )),
    );
  }
}
