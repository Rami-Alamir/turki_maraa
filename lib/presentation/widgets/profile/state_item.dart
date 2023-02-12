import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/utilities/app_localizations.dart';

class StateItem extends StatelessWidget {
  final String? routeName;
  final String title;
  final String icon;
  final double value;
  const StateItem(
      {Key? key,
      required this.title,
      required this.icon,
      required this.value,
      this.routeName = ""})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (routeName!.isNotEmpty) {
          Navigator.pushNamed(context, routeName!, arguments: true);
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(convertDouble(value),
              style: Theme.of(context).textTheme.titleLarge),
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
                        .titleSmall!
                        .copyWith(fontSize: 13)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String convertDouble(double value) {
    return value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 2);
  }
}
