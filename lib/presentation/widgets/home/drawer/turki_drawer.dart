import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'drawer_row.dart';
import 'turki_drawer_footer.dart';
import '../../shared/social_media.dart';
import '../../shared/user_data_header.dart';
import '../../../../controllers/app_language.dart';
import '../../../../controllers/drawer_provider.dart';
import '../../../../controllers/app_theme.dart';
import '../../../../controllers/location_provider.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/fixed_assets.dart';
import '../../../../core/service/firebase_helper.dart';
import '../../../../core/utilities/app_localizations.dart';
import '../../../../core/utilities/size_config.dart';

class TurkiDrawer extends StatelessWidget {
  final Widget child;
  const TurkiDrawer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Consumer3<DrawerProvider, AppTheme, AppLanguage>(
        builder: (_, drawerProvider, theme, language, __) {
      return AdvancedDrawer(
        backdropColor: Theme.of(context).colorScheme.background,
        controller: drawerProvider.advancedDrawerController,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        animateChildDecoration: true,
        openRatio: 0.75,
        rtlOpening: language.isArabic,
        disabledGestures: true,
        childDecoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        drawer: SafeArea(
          child: InkWell(
            onTap: () {
              drawerProvider.hideDrawer();
            },
            child: Column(
              children: [
                const UserDataHeader(),
                SizedBox(
                  height: (SizeConfig.screenHeight! * 0.6),
                  child: ListView(
                    children: [
                      DrawerRow(
                        onTap: () {
                          drawerProvider.hideDrawer();
                        },
                        isSvg: false,
                        icon: FixedAssets.turkiIcon,
                        title: 'home',
                      ),
                      DrawerRow(
                        onTap: () {
                          drawerProvider.navigateTo(context, '/Favourite');
                        },
                        icon: FixedAssets.favorites,
                        title: 'favorite',
                      ),
                      DrawerRow(
                        onTap: () {
                          drawerProvider.navigateTo(context, '/FAQ');
                        },
                        icon: FixedAssets.questionsIcon,
                        title: 'faq',
                      ),
                      DrawerRow(
                        onTap: () {
                          drawerProvider.navigateTo(context, '/About');
                        },
                        icon: FixedAssets.aboutIcon,
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
                          FirebaseHelper()
                              .pushAnalyticsEvent(name: "contact_via_whatsApp");
                          String phone =
                              context.read<LocationProvider>().isoCountryCode ==
                                      "AE"
                                  ? Constants.uaeWhats
                                  : Constants.ksaWhats;
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
                        title: 'contact_whatsApp',
                      ),
                      DrawerRow(
                        onTap: () {
                          FirebaseHelper().pushAnalyticsEvent(name: "share");
                          _share(context);
                        },
                        icon: FixedAssets.share,
                        title: 'share',
                      ),
                      DrawerRow(
                        onTap: () {
                          FirebaseHelper().pushAnalyticsEvent(
                              name: "app_rate",
                              value: Platform.isIOS
                                  ? "Apple Store"
                                  : context.read<LocationProvider>().isHms
                                      ? "AppGallery"
                                      : "Google Play");
                          if (context.read<LocationProvider>().isHms) {
                          } else {
                            final InAppReview inAppReview =
                                InAppReview.instance;
                            inAppReview.openStoreListing(
                                appStoreId: 'id1115628569');
                          }
                        },
                        icon: FixedAssets.rate,
                        title: 'rate_the_app',
                      ),
                      DrawerRow(
                        onTap: () {
                          FirebaseHelper().pushAnalyticsEvent(
                              name: 'change_app_language',
                              value: AppLocalizations.of(context)!
                                  .locale!
                                  .languageCode);
                          language.changeLanguage();
                        },
                        icon: FixedAssets.language,
                        title: 'language',
                      ),
                      if (theme.themeName != 'main')
                        DrawerRow(
                          onTap: () {
                            FirebaseHelper().pushAnalyticsEvent(
                                name: 'change_app_theme', value: 'main');
                            theme.changeTheme('main');
                          },
                          icon: FixedAssets.main,
                          title: 'main_theme',
                        ),
                      if (theme.themeName != 'light')
                        DrawerRow(
                          onTap: () {
                            FirebaseHelper().pushAnalyticsEvent(
                                name: 'change_app_theme', value: 'light');
                            theme.changeTheme('light');
                          },
                          icon: FixedAssets.light,
                          title: 'light_mode',
                        ),
                      if (theme.themeName != 'classic')
                        DrawerRow(
                          onTap: () {
                            FirebaseHelper().pushAnalyticsEvent(
                                name: 'change_app_theme', value: 'classic');
                            theme.changeTheme('classic');
                          },
                          icon: FixedAssets.classic,
                          title: 'classic_mode',
                        ),
                      if (theme.themeName != 'dark')
                        DrawerRow(
                          onTap: () {
                            FirebaseHelper().pushAnalyticsEvent(
                                name: 'change_app_theme', value: 'dark');
                            theme.changeTheme('dark');
                          },
                          icon: FixedAssets.dark,
                          title: 'dark_mode',
                        ),
                    ],
                  ),
                ),
                const SocialMedia(),
                TurkiDrawerFooter(
                  ltr: !language.isArabic,
                )
              ],
            ),
          ),
        ),
        child: child,
      );
    });
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
    Share.share(Constants.shareUrl,
        subject: AppLocalizations.of(context)!.tr('turki_app'));
  }
}
