import 'package:flutter/material.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:new_turki/widgets/shared/rounded_rectangle_button.dart';

class NotAuth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Image.asset('assets/images/not_auth.png',
                width: 200, height: 200),
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
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            title: AppLocalizations.of(context)!.tr('login'),
            onPressed: () =>
                Navigator.of(context, rootNavigator: true).pushNamed('/Login'),
          )
        ],
      ),
    );
  }
}
