import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utilities/format_helper.dart';
import '../../../core/service/service_locator.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/size_config.dart';

class MinValueIndicator extends StatelessWidget {
  final double min;
  final double total;
  final String currency;

  const MinValueIndicator(
      {Key? key,
      required this.min,
      required this.total,
      required this.currency})
      : super(key: key);
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
              style: Theme.of(context).textTheme.headlineMedium,
              children: <TextSpan>[
                TextSpan(
                    text:
                        ' ${sl<FormatHelper>().formatDecimalAndRemoveTrailingZeros(min - total)} $currency ',
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 13)),
                TextSpan(
                    text: AppLocalizations.of(context)!.tr('min_charge_order')),
              ],
            ),
          ),
          Container(
            width: SizeConfig.screenWidth! - 40,
            height: 7,
            margin: const EdgeInsetsDirectional.fromSTEB(5, 15, 5, 5),
            decoration: BoxDecoration(
              color: AppColors.grey,
              borderRadius: const BorderRadius.all(Radius.circular(2)),
              boxShadow: [
                BoxShadow(
                  color:
                      Theme.of(context).colorScheme.secondary.withOpacity(0.4),
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
                    borderRadius: const BorderRadius.all(Radius.circular(2)),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
