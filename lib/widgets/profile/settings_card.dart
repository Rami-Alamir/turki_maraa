import 'package:flutter/material.dart';
import 'package:new_turki/provider/address_provider.dart';
import 'package:new_turki/provider/app_language.dart';
import 'package:new_turki/provider/app_theme.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:new_turki/widgets/shared/main_card.dart';
import 'package:provider/provider.dart';
import '../../utilities/firebase_helper.dart';
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
              width: SizeConfig.screenWidth!,
              padding: EdgeInsets.only(bottom: 1, right: 7, left: 7),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  children: [
                    ProfileRow(
                        onTap: () {
                          final _addressProvider = Provider.of<AddressProvider>(
                              context,
                              listen: false);
                          _addressProvider.getAddressFromLatLng(
                              AppLocalizations.of(context)!.locale !=
                                      Locale('ar')
                                  ? "AR"
                                  : "EN",
                              _addressProvider.selectedLatLng);
                          _language.changeLanguage();
                        },
                        icon: 'assets/images/profile_icons/language-color.svg',
                        title: 'language'),
                    Visibility(
                      visible: _theme.themeName != 'light',
                      child: ProfileRow(
                          onTap: () {
                            FirebaseHelper.analytics!.logEvent(
                                name: 'Theme',
                                parameters: {"name": "Light mode"});
                            _theme.changeTheme('light');
                          },
                          icon: 'assets/images/profile_icons/light.svg',
                          title: 'light_mode'),
                    ),
                    Visibility(
                      visible: _theme.themeName != 'classic',
                      child: ProfileRow(
                          onTap: () {
                            FirebaseHelper.analytics!.logEvent(
                                name: 'Theme',
                                parameters: {"name": "Classic mode"});
                            _theme.changeTheme('classic');
                          },
                          withDivider: _theme.themeName != 'dark',
                          icon: 'assets/images/profile_icons/Classic-Mode.svg',
                          title: 'classic_mode'),
                    ),
                    Visibility(
                      visible: _theme.themeName != 'dark',
                      child: ProfileRow(
                          onTap: () {
                            FirebaseHelper.analytics!.logEvent(
                                name: 'Theme',
                                parameters: {"name": "Dark mode"});
                            _theme.changeTheme('dark');
                          },
                          withDivider: false,
                          icon: 'assets/images/profile_icons/dark-mode.svg',
                          title: 'dark_mode'),
                    ),
                  ],
                ),
              )),
        ]);
  }
}
