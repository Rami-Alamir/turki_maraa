import 'package:flutter/material.dart';
import 'package:new_turki/models/intro_list.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:new_turki/widgets/intro/intro_card.dart';
import 'package:new_turki/widgets/intro/intro_footer.dart';
import 'package:new_turki/widgets/intro/intro_language.dart';
import 'package:new_turki/widgets/shared/dots_indicator.dart';

class Intro extends StatefulWidget {
  @override
  _IntroState createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  int mSelectedPosition = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        IntroLanguage(),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(
                top: SizeConfig.deviceScreenType == DeviceScreenType.Desktop
                    ? 80.0
                    : 0.0),
            child: PageView.builder(
              controller: PageController(
                  initialPage: mSelectedPosition,
                  keepPage: true,
                  viewportFraction: 1),
              itemCount: IntroList.introData.length,
              onPageChanged: (index) {
                setState(() {
                  mSelectedPosition = index;
                });
              },
              itemBuilder: (context, i) {
                return IntroCard(mSelectedPosition: mSelectedPosition);
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 80.0),
          child: DotsIndicator(
            index: mSelectedPosition,
            count: IntroList.introData.length,
            accentColor: Color.fromRGBO(132, 15, 15, 0.1),
          ),
        ),
        IntroFooter(
            mSelectedPosition: mSelectedPosition,
            next: () {
              setState(() {
                mSelectedPosition = mSelectedPosition + 1;
              });
            })
      ],
    ));
  }
}
