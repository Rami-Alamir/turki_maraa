import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../models/about.dart';
import '../../utilities/app_localizations.dart';
import '../../utilities/size_config.dart';
import '../../widgets/profile/services_item.dart';
import '../../widgets/shared/primary_app_bar.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    final bool _isAr = AppLocalizations.of(context)!.locale == Locale('ar');
    return Scaffold(
      appBar: PrimaryAppBar(
        title: AppLocalizations.of(context)!.tr('about'),
        back: true,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                width: SizeConfig.screenWidth,
                height: 190,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/ww1.png'),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 28.0),
                      child: Image.asset(
                        "assets/images/turki_icon.png",
                        width: 120,
                        height: 200,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Column(
            children: [
              aboutHeader(
                  title: AppLocalizations.of(context)!.tr('about2'),
                  subtitle: AppLocalizations.of(context)!.tr('app_name')),
              aboutText(_isAr ? AboutData.aboutAr[0] : AboutData.aboutEn[0],
                  EdgeInsets.only(top: 18.0, bottom: 18, right: 15, left: 15)),
              aboutText(_isAr ? AboutData.aboutAr[1] : AboutData.aboutEn[1],
                  EdgeInsets.only(top: 0.0, bottom: 18, right: 15, left: 15))
            ],
          ),
          Column(
            children: [
              aboutRow('our_vision', 'assets/images/profile_icons/vision.svg'),
              aboutText(_isAr ? AboutData.aboutAr[2] : AboutData.aboutEn[2],
                  EdgeInsets.only(top: 18.0, bottom: 18, right: 5, left: 5)),
              aboutRow('our_goal', 'assets/images/profile_icons/goal.svg'),
              aboutText(_isAr ? AboutData.aboutAr[3] : AboutData.aboutEn[3],
                  EdgeInsets.only(top: 18.0, bottom: 18, right: 5, left: 5)),
              aboutRow('our_value', 'assets/images/profile_icons/value.svg'),
              aboutText(_isAr ? AboutData.aboutAr[4] : AboutData.aboutEn[4],
                  EdgeInsets.only(top: 18.0, bottom: 18, right: 5, left: 5)),
            ],
          ),
          Column(
            children: [
              aboutHeader(
                title: AppLocalizations.of(context)!.tr('our_services'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: SizeConfig.screenWidth! / 1.6,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20.0),
                      child: Text(
                        _isAr ? AboutData.aboutAr[5] : AboutData.aboutEn[5],
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(
                            fontSize: 14,
                            height: 1.5,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(2.5, 15, 10, 0),
                    child: Image.asset(
                      'assets/images/about.png',
                      height: 120,
                      width: 120,
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Wrap(
                children: [
                  ServicesItem(
                      image: 'assets/images/profile_icons/zabh.svg',
                      title: 'slaughter'),
                  ServicesItem(
                      image: 'assets/images/profile_icons/medical-check.svg',
                      title: 'medical_examination'),
                  ServicesItem(
                      image: 'assets/images/profile_icons/quality.svg',
                      title: 'quality_test'),
                  ServicesItem(
                      image: 'assets/images/profile_icons/delivery.svg',
                      title: 'delivery2'),
                  ServicesItem(
                      image: 'assets/images/profile_icons/cut.svg',
                      title: 'chopping'),
                  ServicesItem(
                      image: 'assets/images/profile_icons/wrapping.svg',
                      title: 'packaging'),
                ],
              )),
        ],
      ),
    );
  }

  Widget aboutHeader({required String title, String subtitle = ''}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
      child: Row(
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headline1!.copyWith(
                  fontSize: 16,
                  height: 1.5,
                ),
          ),
          Text(
            " " + subtitle,
            style: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(fontSize: 16, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget aboutText(String text, EdgeInsets padding) {
    return Padding(
      padding: padding,
      child: FittedBox(
        fit: BoxFit.cover,
        child: Container(
          width: SizeConfig.screenWidth! - 40,
          child: Text(
            text,
            style: Theme.of(context).textTheme.subtitle2!.copyWith(
                fontSize: 14, height: 1.5, fontWeight: FontWeight.normal),
          ),
        ),
      ),
    );
  }

  Widget aboutRow(String title, String image,
      {mainAxisAlignment = MainAxisAlignment.start}) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 15, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: mainAxisAlignment,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(2.5, 15, 10, 0),
            child: SvgPicture.asset(
              image,
              height: 45,
              width: 45,
              fit: BoxFit.fill,
            ),
          ),
          Text(
            AppLocalizations.of(context)!.tr(title),
            style: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(fontSize: 14, height: 3, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
