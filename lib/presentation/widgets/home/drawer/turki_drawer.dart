import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../../controllers/app_language.dart';
import '../../../../controllers/drawer_provider.dart';
import '../../../../controllers/app_theme.dart';
import '../../../../controllers/location_provider.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/fixed_assets.dart';
import '../../../../core/service/firebase_helper.dart';
import '../../../../core/utilities/app_localizations.dart';
import '../../../../core/utilities/size_config.dart';
import '../../shared/social_media.dart';
import '../../shared/user_data_header.dart';
import 'drawer_row.dart';
import 'turki_drawer_footer.dart';

class TurkiDrawer extends StatelessWidget {
  final Widget child;
  const TurkiDrawer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DrawerProvider drawerProvider = Provider.of<DrawerProvider>(context);
    final AppTheme theme = Provider.of<AppTheme>(context);
    final AppLanguage language = Provider.of<AppLanguage>(context);

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
                height: (SizeConfig.screenHeight! * 0.55),
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
                    // DrawerRow(
                    //   onTap: () {
                    //     _appProvider.navigateTo(context, "/Notifications");
                    //   },
                    //   icon: TURKIICONS.notification,
                    //   title: 'notifications',
                    // ),
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
                        final LocationProvider locationProvider =
                            Provider.of<LocationProvider>(context,
                                listen: false);
                        FirebaseHelper()
                            .pushAnalyticsEvent(name: "contact_via_whatsApp");
                        String phone = locationProvider.isoCountryCode == "AE"
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
                        final LocationProvider locationProvider =
                            Provider.of<LocationProvider>(context,
                                listen: false);
                        FirebaseHelper().pushAnalyticsEvent(
                            name: "app_rate",
                            value: Platform.isIOS
                                ? "Apple Store"
                                : locationProvider.isHms
                                    ? "AppGallery"
                                    : "Google Play");
                        if (locationProvider.isHms) {
                        } else {
                          final InAppReview inAppReview = InAppReview.instance;
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
                    Visibility(
                      visible: theme.themeName != 'light',
                      child: DrawerRow(
                        onTap: () {
                          FirebaseHelper().pushAnalyticsEvent(
                              name: 'change_app_theme', value: 'light');
                          theme.changeTheme('light');
                        },
                        icon: FixedAssets.light,
                        title: 'light_mode',
                      ),
                    ),
                    Visibility(
                      visible: theme.themeName != 'classic',
                      child: DrawerRow(
                        onTap: () {
                          FirebaseHelper().pushAnalyticsEvent(
                              name: 'change_app_theme', value: 'classic');
                          theme.changeTheme('classic');
                        },
                        icon: FixedAssets.classic,
                        title: 'classic_mode',
                      ),
                    ),
                    Visibility(
                      visible: theme.themeName != 'dark',
                      child: DrawerRow(
                        onTap: () {
                          FirebaseHelper().pushAnalyticsEvent(
                              name: 'change_app_theme', value: 'dark');
                          theme.changeTheme('dark');
                        },
                        icon: FixedAssets.dark,
                        title: 'dark_mode',
                      ),
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
