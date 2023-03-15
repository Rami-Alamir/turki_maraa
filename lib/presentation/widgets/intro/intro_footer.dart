import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/constants/intro_list.dart';
import '../../../core/constants/route_constants.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/size_config.dart';

class IntroFooter extends StatelessWidget {
  final int mSelectedPosition;

  final Function next;
  const IntroFooter(
      {Key? key, required this.mSelectedPosition, required this.next})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.screenWidth,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Visibility(
              visible: mSelectedPosition == 0,
              child: TextButton(
                onPressed: () {
                  changeIntroStatus();
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(app, (route) => false);
                },
                child: Text(
                  AppLocalizations.of(context)!.tr('skip'),
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.primary),
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward_ios,
                  color: Theme.of(context).colorScheme.primary),
              onPressed: () {
                changeIntroStatus();
                mSelectedPosition + 1 == IntroList.introData.length
                    ? Navigator.of(context)
                        .pushNamedAndRemoveUntil(app, (route) => false)
                    : next();
              },
            )
          ],
        ),
      ),
    );
  }

  // used to save intro status
  void changeIntroStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('intro', false);
  }
}
