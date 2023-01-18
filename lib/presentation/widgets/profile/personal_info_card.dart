import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controllers/auth.dart';
import '../../../core/constants/fixed_assets.dart';
import '../../../core/constants/route_constants.dart';
import '../../widgets/profile/profile_row.dart';
import '../shared/main_card.dart';

class PersonalInfoCard extends StatelessWidget {
  const PersonalInfoCard({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Auth auth = Provider.of<Auth>(context);

    return Visibility(
      visible: auth.isAuth,
      child: MainCard(
          padding: const EdgeInsets.only(bottom: 1, right: 7, left: 7),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              children: [
                ProfileRow(
                    onTap: () =>
                        Navigator.pushNamed(context, personalInformation),
                    icon: FixedAssets.user,
                    title: 'personal_information'),
                ProfileRow(
                    onTap: () => Navigator.pushNamed(context, myAddresses),
                    icon: FixedAssets.myAddresses,
                    title: 'my_addresses'),
                ProfileRow(
                    onTap: () => Navigator.pushNamed(context, favourite),
                    icon: FixedAssets.favorites,
                    withDivider: false,
                    title: 'favorite'),
              ],
            ),
          )),
    );
  }
}
