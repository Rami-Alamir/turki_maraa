import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../core/utilities/size_config.dart';
import '../../../core/constants/fixed_assets.dart';
import '../../../core/utilities/app_localizations.dart';

class Maintenance extends StatelessWidget {
  const Maintenance({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.screenWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(FixedAssets.maintenance,
              height: 250, width: 250, fit: BoxFit.contain),
          Padding(
            padding: const EdgeInsets.only(top: 38.0, bottom: 10),
            child: Text(
              AppLocalizations.of(context)!.tr('dear_customers'),
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .displayLarge!
                  .copyWith(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 20),
            child: Text(
              AppLocalizations.of(context)!.tr('maintenance_msg'),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  fontSize: 13, fontWeight: FontWeight.w600, height: 1.7),
            ),
          ),
        ],
      ),
    );
  }
}
