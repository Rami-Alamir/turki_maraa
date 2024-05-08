import 'package:flutter/material.dart';
import 'about_row.dart';
import 'about_text.dart';
import '../../../../core/constants/about_data.dart';
import '../../../../core/constants/fixed_assets.dart';
import '../../../../core/utilities/app_localizations.dart';

class OurVision extends StatelessWidget {
  const OurVision({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isAr =
        AppLocalizations.of(context)!.locale == const Locale('ar');
    return Column(
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
    );
  }
}
