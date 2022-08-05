import 'package:flutter/material.dart';

import '../../../utilities/app_localizations.dart';
import '../../../utilities/size_config.dart';

class MinValueIndicator extends StatelessWidget {
  final double min;
  final double total;
  final String currency;

  const MinValueIndicator(
      {required this.min, required this.total, required this.currency});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: AppLocalizations.of(context)!.tr('remaining'),
              style: Theme.of(context).textTheme.headline4,
              children: <TextSpan>[
                TextSpan(
                    text: ' ${(min - total).toStringAsFixed(2)} $currency ',
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 13)),
                TextSpan(
                    text: AppLocalizations.of(context)!.tr('min_charge_order')),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(5, 15, 5, 5),
            child: Container(
              width: SizeConfig.screenWidth! - 40,
              height: 7,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(const Radius.circular(2)),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.4),
                    spreadRadius: 2,
                    blurRadius: 1,
                    offset: const Offset(50, 5), // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: (SizeConfig.screenWidth! - 50) * (total / min),
                    height: 7,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.all(const Radius.circular(2)),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
