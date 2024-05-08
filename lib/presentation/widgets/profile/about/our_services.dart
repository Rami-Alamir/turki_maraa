import 'package:flutter/material.dart';
import 'services_item.dart';
import '../../../../core/constants/about_data.dart';
import '../../../../core/constants/fixed_assets.dart';
import '../../../../core/utilities/app_localizations.dart';

class OurServices extends StatelessWidget {
  const OurServices({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isAr =
        AppLocalizations.of(context)!.locale == const Locale('ar');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
          child: Row(
            children: [
              Text(
                AppLocalizations.of(context)!.tr('our_services'),
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      fontSize: 16,
                      height: 1.5,
                    ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20.0),
          child: Text(
            isAr ? AboutData.aboutAr[5] : AboutData.aboutEn[5],
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: 14, height: 1.5, fontWeight: FontWeight.normal),
          ),
        ),
        const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Wrap(
              children: [
                ServicesItem(image: FixedAssets.zabh, title: 'slaughter'),
                ServicesItem(
                    image: FixedAssets.medicalCheck,
                    title: 'medical_examination'),
                ServicesItem(image: FixedAssets.quality, title: 'quality_test'),
                ServicesItem(image: FixedAssets.delivery, title: 'delivery2'),
                ServicesItem(image: FixedAssets.cut, title: 'chopping'),
                ServicesItem(image: FixedAssets.wrapping, title: 'packaging'),
              ],
            )),
      ],
    );
  }
}
