import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:new_turki/widgets/shared/rounded_rectangle_button.dart';
import 'package:app_settings/app_settings.dart';

class LocationDisabled extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 70.0),
      child: Container(
        width: SizeConfig.screenWidth,
        height: SizeConfig.screenHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/not_supported.png',
                width: 250, height: 250),
            SizedBox(
              width: SizeConfig.screenWidth! * .7,
              child: Text(
                AppLocalizations.of(context)!
                    .tr("please_allow_access_to_the_location"),
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(fontSize: 12, height: 2),
              ),
            ),
            RoundedRectangleButton(
                title: AppLocalizations.of(context)!.tr('go_to_settings'),
                onPressed: () {
                  AppSettings.openAppSettings();
                })
          ],
        ),
      ),
    );
  }
}
