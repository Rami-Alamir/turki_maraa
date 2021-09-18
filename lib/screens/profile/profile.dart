import 'package:flutter/material.dart';
import 'package:new_turki/screens/profile/about.dart';
import 'package:new_turki/screens/profile/faq.dart';
import 'package:new_turki/screens/profile/login.dart';
import 'package:new_turki/screens/profile/personal_info.dart';
import 'package:new_turki/utilities/r_a7_i_c_o_n_s_icons.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:new_turki/utilities/social_icons_icons.dart';
import 'package:new_turki/widgets/primary_app_bar.dart';
import 'package:new_turki/widgets/primary_app_bar2.dart';
import 'package:new_turki/widgets/profile/profile_footer.dart';
import 'package:new_turki/widgets/profile/profile_header.dart';
import 'package:new_turki/widgets/profile/profile_row.dart';
import 'package:new_turki/widgets/profile/profile_state.dart';
import 'package:new_turki/widgets/shared/main_card.dart';
import 'favourite.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProfileAppBar(),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: ListView(
          padding: EdgeInsets.only(top: 15),
          children: [
            MainCard(
                width: SizeConfig.screenWidth!,
                padding: EdgeInsets.only(bottom: 0, right: 7, left: 7),
                child: Column(
                  children: [
                    ProfileHeader(),
                    Container(child: ProfileState()),
                  ],
                )),
            MainCard(
                height: 100,
                padding: EdgeInsets.only(bottom: 1, right: 7, left: 7),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    children: [
                      ProfileRow(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PersonalInfo()),
                            );
                          },
                          icon: RA7ICONS.user,
                          title: 'بياناتي'),
                      ProfileRow(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Favourite()),
                            );
                          },
                          withDivider: false,
                          icon: RA7ICONS.heart__1_,
                          title: 'المفضلة'),
                    ],
                  ),
                )),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
              child: Text('الاعدادات',
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        fontSize: 10,
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
                          onTap: () {},
                          icon: RA7ICONS.translator,
                          title: 'English'),
                      ProfileRow(
                          onTap: () {},
                          icon: RA7ICONS.moon,
                          title: 'الوضع الليلي'),
                      ProfileRow(
                          onTap: () {},
                          withDivider: false,
                          icon: RA7ICONS.brightness,
                          title: 'الوضع الكلاسيكي'),
                    ],
                  ),
                )),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
              child: Text('المساعدة والدعم',
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        fontSize: 10,
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
                        onTap: () {},
                        icon: RA7ICONS.comment,
                        title: 'تواصل معنا عبر الواتس اب',
                      ),
                      ProfileRow(
                          onTap: () {},
                          icon: Icons.local_phone_outlined,
                          title: 'اتصل بنا'),
                      ProfileRow(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Faq()),
                            );
                          },
                          icon: Icons.question_answer_outlined,
                          title: 'الأسئلة الشائعة'),
                      ProfileRow(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => About()),
                          );
                        },
                        icon: RA7ICONS.info,
                        title: 'عن تركي للذبائح',
                      ),
                      ProfileRow(
                        onTap: () {},
                        icon: RA7ICONS.share,
                        title: 'مشاركة التطبيق',
                      ),
                      ProfileRow(
                        onTap: () {
                          Navigator.of(context, rootNavigator: true).push(
                            MaterialPageRoute<bool>(
                              fullscreenDialog: true,
                              builder: (BuildContext context) => Login(),
                            ),
                          );
                        },
                        withDivider: false,
                        icon: RA7ICONS.exit,
                        title: 'تسجيل الخروج',
                      ),
                    ],
                  ),
                )),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
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
                          color: Theme.of(context)
                              .textTheme
                              .headline4!
                              .color!
                              .withOpacity(0.5),
                        ),
                        Icon(
                          SocialIcons.snapchat,
                          size: 20,
                          color: Theme.of(context)
                              .textTheme
                              .headline4!
                              .color!
                              .withOpacity(0.5),
                        ),
                        Icon(
                          SocialIcons.facebook_2,
                          size: 20,
                          color: Theme.of(context)
                              .textTheme
                              .headline4!
                              .color!
                              .withOpacity(0.5),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ProfileFooter(
              version: '5.0.0',
            )
          ],
        ),
      ),
    );
  }

  Widget profileHeaderCard({required IconData icon, required String title}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Container(
        width: 60,
        height: 60,
        padding: const EdgeInsets.all(3.0),
        constraints: const BoxConstraints(
          minHeight: 60,
        ),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color.fromRGBO(132, 15, 15, 1.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.black,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  //color: Color.fromRGBO(132, 15, 15, 1),

                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
