import 'package:flutter/material.dart';
import '../../../../core/constants/fixed_assets.dart';
import '../../../../core/utilities/app_localizations.dart';
import '../../../../core/utilities/size_config.dart';

class NotSupportedArea extends StatelessWidget {
  const NotSupportedArea({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 80.0),
      child: SizedBox(
        width: SizeConfig.screenWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(FixedAssets.notSupported, width: 200, height: 200),
            SizedBox(
              width: SizeConfig.screenWidth! * .7,
              child: Text(
                AppLocalizations.of(context)!.tr('not_supported_area'),
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(height: 3),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
