import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:new_turki/provider/app_provider.dart';
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
    return AdvancedDrawer(
      backdropColor: Colors.white,
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
                        Text('رامي الأمير',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black)),
                        Text('0580809976',
                            style: TextStyle(
                                fontSize: 14,
                                height: 2,
                                color: Colors.grey,
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
                    onTap: () {
                      appProvider.hideDrawer();
                    },
                    icon: Icons.home,
                    title: 'الرئيسية',
                  ),
                  drawerRow(
                    onTap: () {
                      appProvider.navigateTo(Favourite());
                    },
                    icon: Icons.favorite,
                    title: 'المفضلة',
                  ),
                  drawerRow(
                    onTap: () {
                      appProvider.navigateTo(UserNotification());
                    },
                    icon: Icons.notifications_active,
                    title: 'الاشعارات',
                  ),
                  drawerRow(
                    onTap: () {
                      appProvider.navigateTo(Faq());
                    },
                    icon: Icons.question_answer,
                    title: 'الأسئلة الشائعة',
                  ),
                  drawerRow(
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
                    onTap: () {},
                    icon: Icons.chat,
                    title: 'تواصل معنا عبر الواتس اب',
                  ),
                  drawerRow(
                    onTap: () {},
                    icon: Icons.share,
                    title: 'مشاركة التطبيق',
                  ),
                  drawerRow(
                    onTap: () {},
                    icon: Icons.language,
                    title: 'English',
                  ),
                  drawerRow(
                    onTap: () {},
                    icon: Icons.brightness_1_rounded,
                    title: 'الوضع الكلاسيكي',
                  ),
                  drawerRow(
                    onTap: () {},
                    icon: Icons.brightness_3,
                    title: 'الوضع الليلي',
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
                        child: Text('الاتصال بالدعم',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.black)),
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
              child: Icon(icon),
            ),
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
