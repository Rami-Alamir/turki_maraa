import 'package:flutter/material.dart';
import '../../widgets/intro/intro_card.dart';
import '../../widgets/intro/intro_footer.dart';
import '../../widgets/intro/intro_language.dart';
import '../../widgets/shared/dots_indicator.dart';
import '../../../core/constants/intro_list.dart';
import '../../../core/utilities/enum/device_screen_type.dart';
import '../../../core/utilities/size_config.dart';

class Intro extends StatefulWidget {
  const Intro({Key? key}) : super(key: key);

  @override
  IntroState createState() => IntroState();
}

class IntroState extends State<Intro> {
  int mSelectedPosition = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        const IntroLanguage(),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(
                top: SizeConfig.deviceScreenType == DeviceScreenType.desktop
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
            accentColor: Theme.of(context).colorScheme.secondaryContainer,
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
