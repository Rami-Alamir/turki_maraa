import 'package:flutter/material.dart';
import 'about_text.dart';
import '../../../../core/constants/about_data.dart';
import '../../../../core/utilities/app_localizations.dart';

class AboutBody extends StatelessWidget {
  const AboutBody({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isAr =
        AppLocalizations.of(context)!.locale == const Locale('ar');
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
          child: Row(
            children: [
              Text(
                AppLocalizations.of(context)!.tr('about2'),
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      fontSize: 16,
                      height: 1.5,
                    ),
              ),
              Text(
                " ${AppLocalizations.of(context)!.tr('app_name')}",
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(fontSize: 16, height: 1.5),
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
    );
  }
}
