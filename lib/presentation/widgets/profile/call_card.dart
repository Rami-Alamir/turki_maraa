import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../controllers/location_provider.dart';
import '../../../core/constants/constants.dart';
import '../../../core/constants/fixed_assets.dart';
import '../../../core/service/firebase_helper.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/size_config.dart';
import '../shared/main_card.dart';

class CallCard extends StatelessWidget {
  const CallCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainCard(
        height: 40,
        width: SizeConfig.screenWidth!,
        padding: const EdgeInsets.only(bottom: 1, right: 7, left: 7),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              final LocationProvider locationProvider =
                  Provider.of<LocationProvider>(context, listen: false);
              FirebaseHelper().pushAnalyticsEvent(name: "contact_support");
              _launchURL(locationProvider.isoCountryCode == "AE"
                  ? "tel:${KConstants.uaePhone}"
                  : 'tel:${KConstants.ksaPhone}');
            },
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0, top: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: SvgPicture.asset(
                          FixedAssets.support,
                        ),
                      ),
                      Text(AppLocalizations.of(context)!.tr('contact_support'),
                          style:
                              Theme.of(context).textTheme.headline4!.copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                  )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  //used to make calls, whatsapp
  Future<void> _launchURL(String url) async {
    try {
      if (await canLaunchUrlString(url)) {
        await launchUrlString(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (_) {}
  }
}
