import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:new_turki/provider/app_language.dart';
import 'package:new_turki/provider/app_provider.dart';
import 'package:new_turki/provider/app_theme.dart';
import 'package:new_turki/provider/auth.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:new_turki/widgets/shared/drawer/turki_drawer_footer.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import '../social_media.dart';
import 'drawer_row.dart';
import '../user_data_header.dart';

class TurkiDrawer extends StatelessWidget {
  final Widget child;
  TurkiDrawer({required this.child});

  @override
  Widget build(BuildContext context) {
    final _appProvider = Provider.of<AppProvider>(context, listen: false);
    final _theme = Provider.of<AppTheme>(context);
    final _language = Provider.of<AppLanguage>(context);
    final _auth = Provider.of<Auth>(context);
    return AdvancedDrawer(
      backdropColor: Theme.of(context).backgroundColor,
      controller: _appProvider.advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      openRatio: 0.75,
      rtlOpening: _language.isArabic,
      disabledGestures: false,
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
            UserDataHeader(user: _auth.user, isAuth: _auth.isAuth),
            Container(
              height: (SizeConfig.screenHeight! * 0.55),
              child: ListView(
                children: [
                  DrawerRow(
                    onTap: () {
                      _appProvider.hideDrawer();
                    },
                    icon: Icons.home,
                    title: 'home',
                  ),
                  DrawerRow(
                    onTap: () {
                      _appProvider.navigateTo(context, '/Favourite');
                    },
                    icon: Icons.favorite,
                    title: 'favorite',
                  ),
                  DrawerRow(
                    onTap: () {
                      _appProvider.navigateTo(context, "/Notifications");
                    },
                    icon: Icons.notifications_active,
                    title: 'notifications',
                  ),
                  DrawerRow(
                    onTap: () {
                      _appProvider.navigateTo(context, '/FAQ');
                    },
                    icon: Icons.question_answer,
                    title: 'faq',
                  ),
                  DrawerRow(
                    onTap: () {
                      _appProvider.navigateTo(context, '/About');
                    },
                    icon: Icons.info,
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
                      String phone = '+966500852759';
                      String url;
                      if (Platform.isIOS)
                        url = "whatsapp://wa.me/$phone/?text=${Uri.parse(' ')}";
                      else
                        url =
                            "whatsapp://send?phone=$phone&text=${Uri.parse(' ')}";
                      _launchURL(url);
                    },
                    icon: Icons.chat,
                    title: 'contact_whatsApp',
                  ),
                  DrawerRow(
                    onTap: () {
                      _share(context);
                    },
                    icon: Icons.share,
                    title: 'share',
                  ),
                  DrawerRow(
                    onTap: () {
                      _language.changeLanguage();
                    },
                    icon: Icons.language,
                    title: 'language',
                  ),
                  Visibility(
                    visible: _theme.themeName != 'light',
                    child: DrawerRow(
                      onTap: () {
                        _theme.changeTheme('light');
                      },
                      icon: Icons.brightness_4,
                      title: 'light_mode',
                    ),
                  ),
                  Visibility(
                    visible: _theme.themeName != 'classic',
                    child: DrawerRow(
                      onTap: () {
                        _theme.changeTheme('classic');
                      },
                      icon: Icons.brightness_1_rounded,
                      title: 'classic_mode',
                    ),
                  ),
                  Visibility(
                    visible: _theme.themeName != 'dark',
                    child: DrawerRow(
                      onTap: () {
                        _theme.changeTheme('dark');
                      },
                      icon: Icons.brightness_3,
                      title: 'dark_mode',
                    ),
                  ),
                ],
              ),
            ),
            SocialMedia(),
            TurkiDrawerFooter(ltr: !_language.isArabic)
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
    Share.share('text', subject: AppLocalizations.of(context)!.tr('turki_app'));
  }
}