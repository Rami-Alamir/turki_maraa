import 'package:flutter/material.dart';
import 'package:new_turki/provider/app_language.dart';
import 'package:new_turki/provider/app_theme.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/ra7_icons.dart';
import 'package:new_turki/widgets/shared/main_card.dart';
import 'package:provider/provider.dart';
import 'profile_row.dart';

class SettingsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _language = Provider.of<AppLanguage>(context);
    final _theme = Provider.of<AppTheme>(context);
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
            child: Text(AppLocalizations.of(context)!.tr('settings'),
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
                          _language.changeLanguage();
                        },
                        icon: RA7ICONS.translator,
                        title: 'language'),
                    Visibility(
                      visible: _theme.themeName != 'light',
                      child: ProfileRow(
                          onTap: () {
                            _theme.changeTheme('light');
                          },
                          icon: RA7ICONS.brightness,
                          title: 'light_mode'),
                    ),
                    Visibility(
                      visible: _theme.themeName != 'classic',
                      child: ProfileRow(
                          onTap: () {
                            _theme.changeTheme('classic');
                          },
                          withDivider: _theme.themeName != 'dark',
                          icon: RA7ICONS.brightness,
                          title: 'classic_mode'),
                    ),
                    Visibility(
                      visible: _theme.themeName != 'dark',
                      child: ProfileRow(
                          onTap: () {
                            _theme.changeTheme('dark');
                          },
                          withDivider: false,
                          icon: RA7ICONS.moon,
                          title: 'dark_mode'),
                    ),
                  ],
                ),
              )),
        ]);
  }
}
