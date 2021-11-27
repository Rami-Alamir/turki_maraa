import 'package:flutter/material.dart';
import 'package:new_turki/models/user.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/size_config.dart';

class ProfileState extends StatelessWidget {
  final User user;

  const ProfileState({required this.user});

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
                    routeName: "/Orders",
                    value: user.orders!,
                    title: 'orders'),
                _verticalDivider(
                  context: context,
                ),
                _stateItem(
                    context: context,
                    routeName: "/UserPoints",
                    value: user.point!,
                    title: 'my_points'),
                _verticalDivider(
                  context: context,
                ),
                _stateItem(
                    context: context,
                    routeName: "/UserWallet",
                    value: user.credit!,
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
      required String routeName,
      required String title,
      required double value}) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, routeName, arguments: true),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(convertDouble(value),
              style: Theme.of(context).textTheme.headline6),
          Text(AppLocalizations.of(context)!.tr(title),
              style: Theme.of(context).textTheme.subtitle2),
        ],
      ),
    );
  }

  Widget _verticalDivider({required BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 40,
        color: Theme.of(context).colorScheme.secondaryVariant,
        width: 1,
      ),
    );
  }
}
