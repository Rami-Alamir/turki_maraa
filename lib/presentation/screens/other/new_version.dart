import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../core/constants/app_colors.dart';
import '../../widgets/shared/rounded_rectangle_button.dart';
import '../../../controllers/app_provider.dart';
import '../../../controllers/location_provider.dart';
import '../../../core/constants/constants.dart';
import '../../../core/constants/fixed_assets.dart';
import '../../../core/service/firebase_helper.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/size_config.dart';

class NewVersion extends StatelessWidget {
  const NewVersion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      body: Container(
        width: SizeConfig.screenWidth,
        height: SizeConfig.screenHeight,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(FixedAssets.background),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: SizeConfig.screenHeight! * 0.2),
              child: Image.asset(
                FixedAssets.logo,
                width: 180,
                height: 180,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: SizeConfig.screenHeight! * 0.15, bottom: 15),
              child: Text(AppLocalizations.of(context)!.tr('new_update'),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: AppColors.gold,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              width: SizeConfig.screenWidth! * 0.85,
              child: Text(AppLocalizations.of(context)!.tr('new_update_desc'),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: AppColors.gold,
                      height: 1.5,
                      fontSize: 16,
                      fontWeight: FontWeight.w300)),
            ),
            Expanded(
              flex: 1,
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: RoundedRectangleButton(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                  title: AppLocalizations.of(context)!.tr('update_now'),
                  onPressed: () async {
                    FirebaseHelper().pushAnalyticsEvent(
                        name: "mandatory_update",
                        value: Platform.isIOS ? "ios" : "android");
                    final locationProvider =
                        Provider.of<LocationProvider>(context, listen: false);
                    await _launchURL(appProvider.url ??
                        (Platform.isIOS
                            ? Constants.appStore
                            : locationProvider.isHms
                                ? Constants.appGallery
                                : Constants.playStore));
                  },
                  fontSize: 24,
                  fontColor: AppColors.gold,
                  color: AppColors.purple3,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future _launchURL(String url) async {
    try {
      if (await canLaunchUrlString(url)) {
        await launchUrlString(url, mode: LaunchMode.externalApplication);
      }
    } catch (_) {}
  }
}
