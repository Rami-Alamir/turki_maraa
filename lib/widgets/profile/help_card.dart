import 'dart:io';
import 'package:flutter/material.dart';
import 'package:new_turki/provider/address_provider.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:new_turki/widgets/profile/logout_row.dart';
import 'package:new_turki/widgets/shared/main_card.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'call_card.dart';
import 'profile_row.dart';

class HelpCard extends StatelessWidget {
  final bool isAuth;

  const HelpCard({required this.isAuth});
  @override
  Widget build(BuildContext context) {
    final _addressProvider =
        Provider.of<AddressProvider>(context, listen: false);

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
              padding: EdgeInsets.only(bottom: 1, right: 7, left: 7),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  children: [
                    ProfileRow(
                        onTap: () {
                          String phone = _addressProvider.isoCountryCode == "AE"
                              ? "+971544055556"
                              : '+966500852759';
                          String url;
                          if (Platform.isIOS)
                            url =
                                "whatsapp://wa.me/$phone/?text=${Uri.parse(' ')}";
                          else
                            url =
                                "whatsapp://send?phone=$phone&text=${Uri.parse(' ')}";
                          _launchURL(url);
                        },
                        icon:
                            'assets/images/profile_icons/whatsapp-colored.svg',
                        title: 'contact_whatsApp'),
                    ProfileRow(
                        onTap: () => Navigator.pushNamed(context, '/FAQ'),
                        icon: 'assets/images/profile_icons/questions.svg',
                        title: 'faq'),
                    ProfileRow(
                        onTap: () => Navigator.pushNamed(context, '/About'),
                        icon: 'assets/images/profile_icons/about.svg',
                        title: 'about'),
                    ProfileRow(
                        onTap: () {
                          _share(context);
                        },
                        withDivider: false,
                        icon: 'assets/images/profile_icons/share-colored.svg',
                        title: 'share'),
                  ],
                ),
              )),
          CallCard(),
          LogOutRow(isAuth: isAuth)
        ]);
  }

  //used to make calls, whatsapp
  Future<void> _launchURL(String url) async {
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print(e.toString());
    }
  }

  //used to share app url
  Future<void> _share(BuildContext context) async {
    Share.share('https://bit.ly/3tB2qdu',
        subject: AppLocalizations.of(context)!.tr('turki_app'));
  }
}
