import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:new_turki/provider/address_provider.dart';
import 'package:new_turki/provider/app_language.dart';
import 'package:new_turki/provider/app_provider.dart';
import 'package:new_turki/provider/app_theme.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:new_turki/widgets/shared/drawer/turki_drawer_footer.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher_string.dart';
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
                    isSvg: false,
                    icon: 'assets/images/turki_icon_small.png',
                    title: 'home',
                  ),
                  DrawerRow(
                    onTap: () {
                      FirebaseHelper.analytics!
                          .logEvent(name: 'Favourite', parameters: null);
                      _appProvider.navigateTo(context, '/Favourite');
                    },
                    icon: 'assets/images/profile_icons/favorites.svg',
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
                    icon: 'assets/images/profile_icons/questions.svg',
                    title: 'faq',
                  ),
                  DrawerRow(
                    onTap: () {
                      FirebaseHelper.analytics!
                          .logEvent(name: 'About', parameters: null);

                      _appProvider.navigateTo(context, '/About');
                    },
                    icon: 'assets/images/profile_icons/about.svg',
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
                    icon: 'assets/images/profile_icons/whatsapp-colored.svg',
                    title: 'contact_whatsApp',
                  ),
                  DrawerRow(
                    onTap: () {
                      FirebaseHelper.analytics!
                          .logEvent(name: 'Share', parameters: null);
                      _share(context);
                    },
                    icon: 'assets/images/profile_icons/share-colored.svg',
                    title: 'share',
                  ),
                  DrawerRow(
                    onTap: () {
                      _language.changeLanguage();
                    },
                    icon: 'assets/images/profile_icons/language-color.svg',
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
                      icon: 'assets/images/profile_icons/light.svg',
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
                      icon: 'assets/images/profile_icons/Classic-Mode.svg',
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
                      icon: 'assets/images/profile_icons/dark-mode.svg',
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
      if (await canLaunchUrlString(url)) {
        await launchUrlString(url);
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
