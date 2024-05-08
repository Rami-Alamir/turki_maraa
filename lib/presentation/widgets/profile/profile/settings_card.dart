import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'profile_row.dart';
import '../../shared/main_card.dart';
import '../../../../controllers/app_language.dart';
import '../../../../controllers/app_theme.dart';
import '../../../../core/constants/fixed_assets.dart';
import '../../../../core/utilities/app_localizations.dart';
import '../../../../core/utilities/size_config.dart';
import '../../../../core/service/firebase_helper.dart';

class SettingsCard extends StatelessWidget {
  const SettingsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<AppLanguage, AppTheme>(builder: (_, language, theme, __) {
      return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
              child: Text(AppLocalizations.of(context)!.tr('settings'),
                  style: Theme.of(context).textTheme.displayMedium),
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
                            FirebaseHelper().pushAnalyticsEvent(
                                name: 'change_app_language',
                                value: AppLocalizations.of(context)!
                                    .locale!
                                    .languageCode);
                            language.changeLanguage();
                          },
                          withArrow: false,
                          icon: FixedAssets.language,
                          title: 'language'),
                      if (theme.themeName != 'main')
                        ProfileRow(
                            onTap: () {
                              FirebaseHelper().pushAnalyticsEvent(
                                  name: 'change_app_theme', value: 'main');
                              theme.changeTheme('main');
                            },
                            withArrow: false,
                            icon: FixedAssets.main,
                            title: 'main_theme'),
                      if (theme.themeName != 'light')
                        ProfileRow(
                            onTap: () {
                              FirebaseHelper().pushAnalyticsEvent(
                                  name: 'change_app_theme', value: 'light');
                              theme.changeTheme('light');
                            },
                            withArrow: false,
                            icon: FixedAssets.light,
                            title: 'light_mode'),
                      if (theme.themeName != 'classic')
                        ProfileRow(
                            onTap: () {
                              FirebaseHelper().pushAnalyticsEvent(
                                  name: 'change_app_theme', value: 'classic');
                              theme.changeTheme('classic');
                            },
                            withArrow: false,
                            withDivider: theme.themeName != 'dark',
                            icon: FixedAssets.classic,
                            title: 'classic_mode'),
                      if (theme.themeName != 'dark')
                        ProfileRow(
                            onTap: () {
                              FirebaseHelper().pushAnalyticsEvent(
                                  name: 'change_app_theme', value: 'dark');
                              theme.changeTheme('dark');
                            },
                            withArrow: false,
                            withDivider: false,
                            icon: FixedAssets.dark,
                            title: 'dark_mode'),
                    ],
                  ),
                )),
          ]);
    });
  }
}
