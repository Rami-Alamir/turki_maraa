import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:new_turki/provider/address_provider.dart';
import 'package:new_turki/provider/app_language.dart';
import 'package:new_turki/provider/app_provider.dart';
import 'package:new_turki/provider/app_theme.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/r_a7_i_c_o_n_s_icons.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:new_turki/utilities/t_u_r_k_i_i_c_o_n_s_icons.dart';
import 'package:new_turki/widgets/shared/drawer/turki_drawer_footer.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../utilities/firebase_helper.dart';
import '../social_media.dart';
import 'drawer_row.dart';
import '../user_data_header.dart';

class TurkiDrawer extends StatelessWidget {
  final Widget child;
  TurkiDrawer({required this.child});

  @override
  Widget build(BuildContext context) {
    final _appProvider = Provider.of<AppProvider>(context);
    final _theme = Provider.of<AppTheme>(context);
    final _language = Provider.of<AppLanguage>(context);

    return AdvancedDrawer(
      backdropColor: Theme.of(context).backgroundColor,
      controller: _appProvider.advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      openRatio: 0.75,
      rtlOpening: _language.isArabic,
      disabledGestures: true,
      childDecoration: const BoxDecoration(
        //  to add shadow behind the page.
        // Keep in mind that it may cause animation jerks.
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black12,
            blurRadius: 25,
          ),
        ],
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      drawer: SafeArea(
        child: Column(
          children: [
            UserDataHeader(),
            Container(
              height: (SizeConfig.screenHeight! * 0.55),
              child: ListView(
                children: [
                  DrawerRow(
                    onTap: () {
                      _appProvider.hideDrawer();
                    },
                    icon: TURKIICONS.tabnav_home,
                    title: 'home',
                  ),
                  DrawerRow(
                    onTap: () {
                      FirebaseHelper.analytics!
                          .logEvent(name: 'Favourite', parameters: null);
                      _appProvider.navigateTo(context, '/FAQ');
                      _appProvider.navigateTo(context, '/Favourite');
                    },
                    icon: TURKIICONS.cart_favourite,
                    title: 'favorite',
                  ),
                  // DrawerRow(
                  //   onTap: () {
                  //     _appProvider.navigateTo(context, "/Notifications");
                  //   },
                  //   icon: TURKIICONS.notification,
                  //   title: 'notifications',
                  // ),
                  DrawerRow(
                    onTap: () {
                      FirebaseHelper.analytics!
                          .logEvent(name: 'FAQ', parameters: null);
                      _appProvider.navigateTo(context, '/FAQ');
                    },
                    icon: TURKIICONS.messages,
                    title: 'faq',
                  ),
                  DrawerRow(
                    onTap: () {
                      FirebaseHelper.analytics!
                          .logEvent(name: 'About', parameters: null);

                      _appProvider.navigateTo(context, '/About');
                    },
                    icon: TURKIICONS.info_circle,
                    title: 'about',
                  ),
                  Divider(
                    indent: 20,
                    endIndent: SizeConfig.screenWidth! > 500
                        ? SizeConfig.screenWidth! * .4
                        : 88,
                  ),
                  DrawerRow(
                    onTap: () {
                      final _addressProvider =
                          Provider.of<AddressProvider>(context, listen: false);

                      String phone = _addressProvider.isoCountryCode == "AE"
                          ? "+971544055556"
                          : '+966500852759';
                      String url;
                      if (Platform.isIOS)
                        url = "whatsapp://wa.me/$phone/?text=${Uri.parse(' ')}";
                      else
                        url =
                            "whatsapp://send?phone=$phone&text=${Uri.parse(' ')}";
                      _launchURL(url);
                    },
                    icon: TURKIICONS.whatssapp_outline_1,
                    title: 'contact_whatsApp',
                  ),
                  DrawerRow(
                    onTap: () {
                      FirebaseHelper.analytics!
                          .logEvent(name: 'Share', parameters: null);
                      _share(context);
                    },
                    icon: TURKIICONS.share4_1,
                    title: 'share',
                  ),
                  DrawerRow(
                    onTap: () {
                      _language.changeLanguage();
                    },
                    icon: TURKIICONS.language,
                    title: 'language',
                  ),
                  Visibility(
                    visible: _theme.themeName != 'light',
                    child: DrawerRow(
                      onTap: () {
                        FirebaseHelper.analytics!.logEvent(
                            name: 'Theme', parameters: {"name": "Light mode"});
                        _theme.changeTheme('light');
                      },
                      icon: TURKIICONS.lightmode,
                      title: 'light_mode',
                    ),
                  ),
                  Visibility(
                    visible: _theme.themeName != 'classic',
                    child: DrawerRow(
                      onTap: () {
                        FirebaseHelper.analytics!.logEvent(
                            name: 'Theme',
                            parameters: {"name": "Classic mode"});
                        _theme.changeTheme('classic');
                      },
                      icon: RA7ICONS.brightness,
                      title: 'classic_mode',
                    ),
                  ),
                  Visibility(
                    visible: _theme.themeName != 'dark',
                    child: DrawerRow(
                      onTap: () {
                        FirebaseHelper.analytics!.logEvent(
                            name: 'Theme', parameters: {"name": "Dark mode"});
                        _theme.changeTheme('dark');
                      },
                      icon: TURKIICONS.darkmode,
                      title: 'dark_mode',
                    ),
                  ),
                ],
              ),
            ),
            SocialMedia(),
            TurkiDrawerFooter(
              ltr: !_language.isArabic,
            )
          ],
        ),
      ),
      child: child,
    );
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
