import 'dart:io';
import 'package:flutter/material.dart';
import '../../../core/constants/constants.dart';
import '../../../core/constants/fixed_assets.dart';
import '../../../core/constants/route_constants.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/size_config.dart';
import '../../widgets/profile/profile_row.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../controllers/location_provider.dart';
import '../../../core/service/firebase_helper.dart';
import '../shared/main_card.dart';

class HelpCard extends StatelessWidget {
  final bool isAuth;

  const HelpCard({Key? key, required this.isAuth}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final LocationProvider locationProvider =
        Provider.of<LocationProvider>(context, listen: false);

    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
            child: Text(AppLocalizations.of(context)!.tr('help_and_support'),
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    )),
          ),
          MainCard(
              width: SizeConfig.screenWidth!,
              padding: const EdgeInsets.only(bottom: 1, right: 7, left: 7),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  children: [
                    ProfileRow(
                        onTap: () {
                          FirebaseHelper()
                              .pushAnalyticsEvent(name: "contact_via_whatsApp");
                          String phone = locationProvider.isoCountryCode == "AE"
                              ? KConstants.uaeWhats
                              : KConstants.ksaWhats;
                          String url;
                          if (Platform.isIOS) {
                            url =
                                "whatsapp://wa.me/$phone/?text=${Uri.parse(' ')}";
                          } else {
                            url =
                                "whatsapp://send?phone=$phone&text=${Uri.parse(' ')}";
                          }
                          _launchURL(url);
                        },
                        icon: FixedAssets.whatsapp,
                        title: 'contact_whatsApp'),
                    ProfileRow(
                        onTap: () => Navigator.pushNamed(context, fAQ),
                        icon: FixedAssets.questionsIcon,
                        title: 'faq'),
                    ProfileRow(
                        onTap: () => Navigator.pushNamed(context, about),
                        icon: FixedAssets.aboutIcon,
                        title: 'about'),
                    ProfileRow(
                        onTap: () {
                          FirebaseHelper().pushAnalyticsEvent(name: "share");
                          _share(context);
                        },
                        withDivider: false,
                        icon: FixedAssets.share,
                        title: 'share'),
                  ],
                ),
              )),
        ]);
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

  //used to share app url
  Future<void> _share(BuildContext context) async {
    Share.share(KConstants.shareUrl,
        subject: AppLocalizations.of(context)!.tr('turki_app'));
  }
}
