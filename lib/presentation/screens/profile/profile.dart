import 'package:flutter/material.dart';
import '../../../controllers/auth.dart';
import '../../../controllers/home_provider.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../widgets/profile/call_card.dart';
import '../../widgets/profile/help_card.dart';
import '../../widgets/profile/logout_row.dart';
import '../../widgets/profile/personal_info_card.dart';
import '../../widgets/profile/profile_footer.dart';
import '../../widgets/profile/profile_header.dart';
import '../../widgets/profile/settings_card.dart';
import '../../widgets/shared/primary_app_bar.dart';
import '../../widgets/shared/social_media.dart';
import 'package:provider/provider.dart';
import '../../widgets/shared/spinkit_indicator.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final Auth auth = Provider.of<Auth>(context);
    final HomeProvider homeProvider =
        Provider.of<HomeProvider>(context, listen: false);

    return Scaffold(
      appBar: PrimaryAppBar(
        title: AppLocalizations.of(context)!.tr('profile'),
        back: false,
        // action: Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
        //   child: IconButton(
        //     icon: Icon(
        //       TURKIICONS.notification,
        //       color: Theme.of(context).primaryColor,
        //     ),
        //     onPressed: () => Navigator.pushNamed(context, '/Notifications'),
        //   ),
        // ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: auth.isLoading
            ? const SpinkitIndicator()
            : ListView(
                padding: EdgeInsets.zero,
                children: [
                  ProfileHeader(
                    isAuth: auth.isAuth,
                  ),
                  PersonalInfoCard(isAuth: auth.isAuth),
                  const SettingsCard(),
                  HelpCard(isAuth: auth.isAuth),
                  const CallCard(),
                  LogOutRow(isAuth: auth.isAuth),
                  SocialMedia(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                  ),
                  ProfileFooter(
                    version: homeProvider.currentVersion,
                  )
                ],
              ),
      ),
    );
  }
}