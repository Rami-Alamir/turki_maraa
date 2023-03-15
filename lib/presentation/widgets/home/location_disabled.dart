import 'package:flutter/material.dart';
import 'package:app_settings/app_settings.dart';
import '../shared/rounded_rectangle_button.dart';
import '../../../core/constants/fixed_assets.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/size_config.dart';

class LocationDisabled extends StatelessWidget {
  final int locationStatus;

  const LocationDisabled({Key? key, required this.locationStatus})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.screenWidth,
      height: SizeConfig.screenHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(top: SizeConfig.homeAppBarHeight + 50),
            child:
                Image.asset(FixedAssets.notSupported, width: 185, height: 185),
          ),
          SizedBox(
            width: SizeConfig.screenWidth! * .8,
            child: Text(
              AppLocalizations.of(context)!.tr(locationStatus == 0
                  ? "we_need_your_location_information"
                  : "we_were_unable_to_determine_your_current_location"),
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(height: 2),
            ),
          ),
          Visibility(
            visible: locationStatus == 0,
            child: RoundedRectangleButton(
                title: AppLocalizations.of(context)!
                    .tr('allow_access_to_the_location'),
                onPressed: () {
                  AppSettings.openAppSettings();
                }),
          )
        ],
      ),
    );
  }
}
