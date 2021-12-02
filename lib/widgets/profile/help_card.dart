import 'dart:io';
import 'package:flutter/material.dart';
import 'package:new_turki/provider/auth.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/ra7_icons.dart';
import 'package:new_turki/widgets/shared/main_card.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import 'profile_row.dart';

class HelpCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<Auth>(context, listen: false);
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
              padding: EdgeInsets.only(bottom: 1, right: 7, left: 7),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  children: [
                    ProfileRow(
                        onTap: () {
                          String phone = '+966500852759';
                          String url;
                          if (Platform.isIOS)
                            url =
                                "whatsapp://wa.me/$phone/?text=${Uri.parse(' ')}";
                          else
                            url =
                                "whatsapp://send?phone=$phone&text=${Uri.parse(' ')}";
                          _launchURL(url);
                        },
                        icon: RA7ICONS.translator,
                        title: 'contact_whatsApp'),
                    ProfileRow(
                        onTap: () {
                          _launchURL('tel:+966920002974');
                        },
                        icon: Icons.local_phone_outlined,
                        title: 'contact_support'),
                    ProfileRow(
                        onTap: () => Navigator.pushNamed(context, '/FAQ'),
                        icon: Icons.question_answer_outlined,
                        title: 'faq'),
                    ProfileRow(
                        onTap: () => Navigator.pushNamed(context, '/About'),
                        icon: RA7ICONS.info,
                        title: 'about'),
                    ProfileRow(
                        onTap: () {
                          _share(context);
                        },
                        withDivider: _auth.isAuth,
                        icon: RA7ICONS.share,
                        title: 'share'),
                    Visibility(
                      visible: _auth.isAuth,
                      child: ProfileRow(
                          onTap: () {
                            _auth.logOut(context);
                          },
                          withDivider: false,
                          icon: RA7ICONS.exit,
                          title: 'log_out'),
                    ),
                  ],
                ),
              )),
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
    Share.share('text', subject: AppLocalizations.of(context)!.tr('turki_app'));
  }
}
