import 'package:flutter/material.dart';
import '../../../core/constants/fixed_assets.dart';
import '../../../core/constants/route_constants.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/size_config.dart';
import 'rounded_rectangle_button.dart';

class NotAuth extends StatelessWidget {
  const NotAuth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.screenWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Image.asset(FixedAssets.notAuth, width: 200, height: 200),
          ),
          SizedBox(
            width: SizeConfig.screenWidth! * .75,
            child: Text(
              AppLocalizations.of(context)!
                  .tr('log_in_and_enjoy_the_best_shopping_experience_now'),
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          RoundedRectangleButton(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            title: AppLocalizations.of(context)!.tr('login'),
            onPressed: () =>
                Navigator.of(context, rootNavigator: true).pushNamed(login),
          )
        ],
      ),
    );
  }
}
