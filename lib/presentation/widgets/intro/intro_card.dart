import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:provider/provider.dart';
import '../../../controllers/app_language.dart';
import '../../../core/constants/intro_list.dart';
import '../../../core/utilities/size_config.dart';

class IntroCard extends StatelessWidget {
  final int mSelectedPosition;

  const IntroCard({super.key, required this.mSelectedPosition});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Consumer<AppLanguage>(builder: (_, lang, __) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: SizeConfig.setWidgetWidthWithFactor(0.7, 0.4, 0.3),
                child: Image.asset(
                  IntroList.introData[mSelectedPosition].image!,
                  width: SizeConfig.setWidgetWidthWithFactor(1, .5, .5),
                  height:
                      SizeConfig.setWidgetHeightWithFactor(0.45, 0.49, 0.49),
                  fit: BoxFit.contain,
                ),
              ),
              Container(
                  width: SizeConfig.setWidgetWidthWithFactor(0.8, 0.8, 0.8),
                  padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                  child: AutoSizeText(
                    lang.language == 'ar'
                        ? IntroList.introData[mSelectedPosition].title!
                        : IntroList.introData[mSelectedPosition].titleEn!,
                    textAlign: TextAlign.center,
                    maxFontSize: 20,
                    minFontSize: 16,
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          height: 1.4,
                        ),
                  )),
              Container(
                  width: SizeConfig.setWidgetWidthWithFactor(0.52, 0.52, 0.52),
                  padding: const EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
                  child: AutoSizeText(
                    lang.language == 'ar'
                        ? IntroList.introData[mSelectedPosition].subtitle!
                        : IntroList.introData[mSelectedPosition].subtitleEn!,
                    textAlign: TextAlign.center,
                    maxFontSize: 16,
                    minFontSize: 12,
                    maxLines: 4,
                    style: Theme.of(context).textTheme.bodyLarge,
                  )),
            ],
          );
        }),
      ],
    );
  }
}
