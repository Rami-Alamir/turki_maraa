import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../../controllers/location_provider.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/fixed_assets.dart';
import '../../../../core/service/firebase_helper.dart';
import '../../../../core/utilities/app_localizations.dart';
import 'dart:math' as math;

class TurkiDrawerFooter extends StatelessWidget {
  final bool ltr;

  const TurkiDrawerFooter({Key? key, required this.ltr}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LocationProvider locationProvider =
        Provider.of<LocationProvider>(context, listen: false);

    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(10, 30, 0, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              FirebaseHelper().pushAnalyticsEvent(name: "contact_support");
              _launchURL(locationProvider.isoCountryCode == "AE"
                  ? "tel:${Constants.uaePhone}"
                  : 'tel:${Constants.ksaPhone}');
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Theme.of(context).primaryColor,
                  child: const Icon(
                    Icons.phone,
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10, horizontal: 10.0),
                  child: AutoSizeText(
                    AppLocalizations.of(context)!.tr('contact_support'),
                    style: Theme.of(context).textTheme.headline4,
                    minFontSize: 11,
                    maxFontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(ltr ? math.pi : 0),
            child: Image.asset(
              FixedAssets.turkiCar,
              width: 103,
              height: 75,
            ),
          ),
        ],
      ),
    );
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
