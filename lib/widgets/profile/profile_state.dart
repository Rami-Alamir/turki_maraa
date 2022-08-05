import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:new_turki/models/user_data.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/size_config.dart';

class ProfileState extends StatelessWidget {
  final UserData user;
  final int orders;

  const ProfileState({required this.user, required this.orders});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: SizeConfig.screenWidth! * .85,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _stateItem(
                    context: context,
                    icon: 'assets/images/profile_icons/orders.svg',
                    routeName: "/Orders",
                    value: orders * 1.0,
                    title: 'orders'),
                _verticalDivider(
                  context: context,
                ),
                _stateItem(
                    context: context,
                    icon: 'assets/images/profile_icons/points.svg',

                    //routeName: "/UserPoints",
                    value: double.parse(user.data!.points!),
                    title: 'my_points'),
                _verticalDivider(
                  context: context,
                ),
                _stateItem(
                    context: context,
                    icon: 'assets/images/profile_icons/wallet6.svg',
                    // routeName: "/UserWallet",
                    value: double.parse(user.data!.wallet!),
                    title: 'credit'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String convertDouble(double value) {
    return '${value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 2)}';
  }

  Widget _stateItem(
      {required BuildContext context,
      String routeName = '',
      required String title,
      required String icon,
      required double value}) {
    return InkWell(
      //     onTap: () => Navigator.pushNamed(context, routeName, arguments: true),
      onTap: () {
        if (routeName.length > 0)
          Navigator.pushNamed(context, routeName, arguments: true);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(convertDouble(value),
              style: Theme.of(context).textTheme.headline6),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 5, 0),
                  child: SvgPicture.asset(icon),
                ),
                Text(AppLocalizations.of(context)!.tr(title),
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(fontSize: 13)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _verticalDivider({required BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 50,
        color: Theme.of(context).colorScheme.secondaryContainer,
        width: 0.2,
      ),
    );
  }
}
