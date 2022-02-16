import 'package:flutter/material.dart';
import 'package:new_turki/models/user_data.dart';
import 'package:new_turki/provider/auth.dart';
import 'package:new_turki/provider/orders_provider.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/t_u_r_k_i_i_c_o_n_s_icons.dart';
import 'package:new_turki/widgets/profile/help_card.dart';
import 'package:new_turki/widgets/profile/personal_info_card.dart';
import 'package:new_turki/widgets/profile/profile_footer.dart';
import 'package:new_turki/widgets/profile/profile_header.dart';
import 'package:new_turki/widgets/profile/settings_card.dart';
import 'package:new_turki/widgets/shared/primary_app_bar.dart';
import 'package:new_turki/widgets/shared/social_media.dart';
import 'package:new_turki/widgets/shared/spinkit_indicator.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<Auth>(context);
    final _orders = Provider.of<OrdersProvider>(context);

    return Scaffold(
      appBar: PrimaryAppBar(
        title: AppLocalizations.of(context)!.tr('profile'),
        back: false,
        action: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
          // child: IconButton(
          //   icon: Icon(
          //     TURKIICONS.notification,
          //     color: Theme.of(context).primaryColor,
          //   ),
          //   onPressed: () => Navigator.pushNamed(context, '/Notifications'),
          // ),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: _auth.isLoading
            ? SpinkitIndicator()
            : RefreshIndicator(
                color: Theme.of(context).primaryColor,
                backgroundColor: Theme.of(context).colorScheme.secondary,
                onRefresh: () async {
                  await _auth.delayed();
                },
                child: ListView(
                  padding: EdgeInsets.only(top: 15),
                  children: [
                    ProfileHeader(
                      isAuth: _auth.isAuth,
                      userData: _auth.userData ?? UserData(),
                      ordersCount: (_orders.ordersData?.data?.length ?? 0),
                    ),
                    PersonalInfoCard(isAuth: _auth.isAuth),
                    SettingsCard(),
                    HelpCard(isAuth: _auth.isAuth),
                    SocialMedia(
                      color: Theme.of(context).colorScheme.secondaryVariant,
                    ),
                    ProfileFooter(
                      version: '5.0.0',
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
