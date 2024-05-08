import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../../controllers/location_provider.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/service/firebase_helper.dart';
import '../../../../core/utilities/app_localizations.dart';

class TurkiDrawerFooter extends StatelessWidget {
  final bool ltr;

  const TurkiDrawerFooter({super.key, required this.ltr});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 0, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              FirebaseHelper().pushAnalyticsEvent(name: "contact_support");
              _launchURL(context.read<LocationProvider>().isoCountryCode == "AE"
                  ? "tel:${Constants.uaePhone}"
                  : 'tel:${Constants.ksaPhone}');
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor:
                      Theme.of(context).colorScheme.tertiaryContainer,
                  child: Icon(
                    Icons.phone,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10, horizontal: 10.0),
                  child: AutoSizeText(
                    AppLocalizations.of(context)!.tr('contact_support'),
                    style: Theme.of(context).textTheme.displayMedium,
                    minFontSize: 11,
                    maxFontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          // Transform(
          //   alignment: Alignment.center,
          //   transform: Matrix4.rotationY(ltr ? math.pi : 0),
          //   child: Image.asset(
          //     FixedAssets.turkiCar,
          //     width: 103,
          //     height: 75,
          //   ),
          // ),
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
