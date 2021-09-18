import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:new_turki/provider/app_provider.dart';
import 'package:new_turki/provider/app_theme.dart';
import 'package:new_turki/screens/profile/about.dart';
import 'package:new_turki/screens/profile/faq.dart';
import 'package:new_turki/screens/profile/favourite.dart';
import 'package:new_turki/screens/profile/notification.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:new_turki/utilities/social_icons_icons.dart';
import 'package:provider/provider.dart';

class TurkiDrawer extends StatelessWidget {
  final Widget child;
  TurkiDrawer({required this.child});

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context, listen: false);
    final theme = Provider.of<AppTheme>(context, listen: false);
    return AdvancedDrawer(
      backdropColor: Theme.of(context).backgroundColor,
      controller: appProvider.advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      openRatio: 0.75,
      rtlOpening: true,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        // NOTICE: Uncomment if you want to add shadow behind the page.
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
            Padding(
              padding: const EdgeInsets.only(
                  right: 15.0, left: 15, top: 30, bottom: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Theme.of(context).primaryColor,
                    child: Text('ر ا',
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'رامي الأمير',
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(
                                  fontWeight: FontWeight.w600, fontSize: 14),
                        ),
                        Text('0580809976',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2!
                                .copyWith(
                                    fontSize: 14,
                                    height: 2,
                                    fontWeight: FontWeight.w500))
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: (SizeConfig.screenHeight! * 0.55),
              child: ListView(
                children: [
                  drawerRow(
                    context: context,
                    onTap: () {
                      appProvider.hideDrawer();
                    },
                    icon: Icons.home,
                    title: 'الرئيسية',
                  ),
                  drawerRow(
                    context: context,
                    onTap: () {
                      appProvider.navigateTo(Favourite());
                    },
                    icon: Icons.favorite,
                    title: 'المفضلة',
                  ),
                  drawerRow(
                    context: context,
                    onTap: () {
                      appProvider.navigateTo(UserNotification());
                    },
                    icon: Icons.notifications_active,
                    title: 'الاشعارات',
                  ),
                  drawerRow(
                    context: context,
                    onTap: () {
                      appProvider.navigateTo(Faq());
                    },
                    icon: Icons.question_answer,
                    title: 'الأسئلة الشائعة',
                  ),
                  drawerRow(
                    context: context,
                    onTap: () {
                      appProvider.navigateTo(About());
                    },
                    icon: Icons.info,
                    title: 'عن تركي للذبائح',
                  ),
                  Divider(
                    indent: 20,
                    endIndent: 20,
                    color: Colors.grey.withOpacity(0.35),
                  ),
                  drawerRow(
                    context: context,
                    onTap: () {},
                    icon: Icons.chat,
                    title: 'تواصل معنا عبر الواتس اب',
                  ),
                  drawerRow(
                    context: context,
                    onTap: () {},
                    icon: Icons.share,
                    title: 'مشاركة التطبيق',
                  ),
                  drawerRow(
                    context: context,
                    onTap: () {},
                    icon: Icons.language,
                    title: 'English',
                  ),
                  Visibility(
                    visible: theme.themeName != 'light',
                    child: drawerRow(
                      context: context,
                      onTap: () {
                        theme.changeTheme('light');
                        print('light');
                      },
                      icon: Icons.brightness_4,
                      title: 'الوضع المضيء',
                    ),
                  ),
                  Visibility(
                    visible: theme.themeName != 'classic',
                    child: drawerRow(
                      context: context,
                      onTap: () {
                        theme.changeTheme('classic');
                        print('classic');
                      },
                      icon: Icons.brightness_1_rounded,
                      title: 'الوضع الكلاسيكي',
                    ),
                  ),
                  Visibility(
                    visible: theme.themeName != 'dark',
                    child: drawerRow(
                      context: context,
                      onTap: () {
                        theme.changeTheme('dark');
                        print('dark');
                      },
                      icon: Icons.brightness_3,
                      title: 'الوضع الليلي',
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 150,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          SocialIcons.instagram_2,
                          size: 20,
                          color: Theme.of(context).primaryColor,
                        ),
                        Icon(
                          SocialIcons.snapchat,
                          size: 20,
                          color: Theme.of(context).primaryColor,
                        ),
                        Icon(
                          SocialIcons.facebook_2,
                          size: 20,
                          color: Theme.of(context).primaryColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(20, 70, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Theme.of(context).primaryColor,
                        child: Icon(
                          Icons.phone,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20.0),
                        child: Text(
                          'الاتصال بالدعم',
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(
                                  fontWeight: FontWeight.w600, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                  Image.asset(
                    'assets/images/scooter.png',
                    width: 70,
                    height: 60,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      child: child,
    );
  }

  Widget drawerRow(
      {required IconData icon,
      required BuildContext context,
      required String title,
      required Function onTap}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          onTap();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 15, 0),
              child: Icon(
                icon,
                color: Theme.of(context).textTheme.headline4!.color,
              ),
            ),
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(fontWeight: FontWeight.w600, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
