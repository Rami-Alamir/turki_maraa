import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controllers/auth.dart';
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
import '../../widgets/shared/spinkit_indicator.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Auth auth = Provider.of<Auth>(context);

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
                  const ProfileHeader(),
                  const PersonalInfoCard(),
                  const SettingsCard(),
                  const HelpCard(),
                  const CallCard(),
                  const LogOutRow(),
                  SocialMedia(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                  ),
                  const ProfileFooter()
                ],
              ),
      ),
    );
  }
}
