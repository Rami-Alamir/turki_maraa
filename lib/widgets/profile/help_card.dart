import 'dart:io';
import 'package:flutter/material.dart';
import 'package:new_turki/provider/address_provider.dart';
import 'package:new_turki/provider/auth.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:new_turki/utilities/t_u_r_k_i_i_c_o_n_s_icons.dart';
import 'package:new_turki/widgets/shared/main_card.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
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
                        icon: TURKIICONS.whatssapp_outline_1,
                        title: 'contact_whatsApp'),
                    ProfileRow(
                        onTap: () {
                          _launchURL(_addressProvider.isoCountryCode == "AE"
                              ? "tel:+97180050050"
                              : 'tel:+966920002974');
                        },
                        icon: TURKIICONS.call_calling,
                        title: 'contact_support'),
                    ProfileRow(
                        onTap: () => Navigator.pushNamed(context, '/FAQ'),
                        icon: TURKIICONS.messages,
                        title: 'faq'),
                    ProfileRow(
                        onTap: () => Navigator.pushNamed(context, '/About'),
                        icon: TURKIICONS.info_circle,
                        title: 'about'),
                    ProfileRow(
                        onTap: () {
                          _share(context);
                        },
                        withDivider: isAuth,
                        icon: TURKIICONS.share4_1,
                        title: 'share'),
                    Visibility(
                      visible: isAuth,
                      child: ProfileRow(
                          onTap: () {
                            final _auth =
                                Provider.of<Auth>(context, listen: false);
                            _auth.logOut(context);
                          },
                          withDivider: false,
                          icon: TURKIICONS.logout,
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
    Share.share('https://turki.turkieshop.com/system//shareit/b5ef3',
        subject: AppLocalizations.of(context)!.tr('turki_app'));
  }
}
