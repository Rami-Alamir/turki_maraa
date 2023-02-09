import 'package:flutter/material.dart';
import '../../../core/constants/about_data.dart';
import '../../../core/constants/fixed_assets.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/size_config.dart';
import '../../widgets/profile/about_row.dart';
import '../../widgets/profile/about_text.dart';
import '../../widgets/profile/services_item.dart';
import '../../widgets/shared/primary_app_bar.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isAr =
        AppLocalizations.of(context)!.locale == const Locale('ar');
    return Scaffold(
      appBar: PrimaryAppBar(
        isTransparent: true,
        title: AppLocalizations.of(context)!.tr('about'),
        back: true,
      ),
      body: ListView(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Container(
              width: SizeConfig.screenWidth,
              margin:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12),
              height: 190,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(FixedAssets.background),
                  fit: BoxFit.fill,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 0.0, bottom: 10),
                    child: Image.asset(
                      FixedAssets.logo,
                      width: 150,
                      height: 150,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
                child: Row(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.tr('about2'),
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
                            fontSize: 16,
                            height: 1.5,
                          ),
                    ),
                    Text(
                      " ${AppLocalizations.of(context)!.tr('app_name')}",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(height: 1.5),
                    ),
                  ],
                ),
              ),
              AboutText(
                  title: isAr ? AboutData.aboutAr[0] : AboutData.aboutEn[0],
                  padding: const EdgeInsets.only(
                      top: 18.0, bottom: 18, right: 15, left: 15)),
              AboutText(
                  title: isAr ? AboutData.aboutAr[1] : AboutData.aboutEn[1],
                  padding: const EdgeInsets.only(
                      top: 0.0, bottom: 18, right: 15, left: 15))
            ],
          ),
          Column(
            children: [
              const AboutRow(title: 'our_vision', image: FixedAssets.vision),
              AboutText(
                  title: isAr ? AboutData.aboutAr[2] : AboutData.aboutEn[2],
                  padding: const EdgeInsets.only(
                      top: 18.0, bottom: 18, right: 5, left: 5)),
              const AboutRow(
                  title: 'our_goal',
                  image: FixedAssets.goal,
                  mainAxisAlignment: MainAxisAlignment.end),
              AboutText(
                  title: isAr ? AboutData.aboutAr[3] : AboutData.aboutEn[3],
                  padding: const EdgeInsets.only(
                      top: 18.0, bottom: 18, right: 5, left: 5)),
              const AboutRow(title: 'our_value', image: FixedAssets.value),
              AboutText(
                  title: isAr ? AboutData.aboutAr[4] : AboutData.aboutEn[4],
                  padding: const EdgeInsets.only(
                      top: 18.0, bottom: 18, right: 5, left: 5)),
            ],
          ),
          Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
                child: Row(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.tr('our_services'),
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
                            fontSize: 16,
                            height: 1.5,
                          ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: SizeConfig.screenWidth! / 1.6,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20.0),
                      child: Text(
                        isAr ? AboutData.aboutAr[5] : AboutData.aboutEn[5],
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            height: 1.5, fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(2.5, 15, 10, 0),
                    child: Image.asset(
                      FixedAssets.about,
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
              padding: const EdgeInsets.only(right: 10.0, left: 10, bottom: 30),
              child: Wrap(
                children: const [
                  ServicesItem(image: FixedAssets.zabh, title: 'slaughter'),
                  ServicesItem(
                      image: FixedAssets.medicalCheck,
                      title: 'medical_examination'),
                  ServicesItem(
                      image: FixedAssets.quality, title: 'quality_test'),
                  ServicesItem(image: FixedAssets.delivery, title: 'delivery2'),
                  ServicesItem(image: FixedAssets.cut, title: 'chopping'),
                  ServicesItem(image: FixedAssets.wrapping, title: 'packaging'),
                ],
              )),
        ],
      ),
    );
  }
}
