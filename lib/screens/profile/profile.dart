import 'package:flutter/material.dart';
import 'package:new_turki/provider/auth.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/widgets/profile/help_card.dart';
import 'package:new_turki/widgets/profile/personal_info_card.dart';
import 'package:new_turki/widgets/profile/profile_footer.dart';
import 'package:new_turki/widgets/profile/profile_header.dart';
import 'package:new_turki/widgets/profile/settings_card.dart';
import 'package:new_turki/widgets/shared/primary_app_bar.dart';
import 'package:new_turki/widgets/shared/social_media.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<Auth>(context);

    return Scaffold(
      appBar: PrimaryAppBar(
        title: AppLocalizations.of(context)!.tr('profile'),
        back: false,
        action: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
          child: IconButton(
            icon: Icon(
              Icons.notifications_outlined,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/Notifications');
            },
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: ListView(
          padding: EdgeInsets.only(top: 15),
          children: [
            ProfileHeader(
              user: _auth.user,
              isAuth: _auth.isAuth,
            ),
            PersonalInfoCard(isAuth: _auth.isAuth),
            SettingsCard(),
            HelpCard(),
            SocialMedia(
              color: Theme.of(context).colorScheme.secondaryVariant,
            ),
            ProfileFooter(
              version: '5.0.0',
            )
          ],
        ),
      ),
    );
  }
}
