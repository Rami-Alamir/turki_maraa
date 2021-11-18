import 'package:flutter/material.dart';
import 'package:new_turki/models/intro_list.dart';
import 'package:new_turki/screens/app/app.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroFooter extends StatelessWidget {
  final int mSelectedPosition;

  final Function next;
  const IntroFooter({required this.mSelectedPosition, required this.next});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => App()),
                  );
                },
                child: Text(
                  AppLocalizations.of(context)!.tr('skip'),
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color.fromRGBO(132, 15, 15, 1),
                  ),
                ),
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.arrow_forward_ios,
                color: Color.fromRGBO(132, 15, 15, 1),
              ),
              onPressed: () {
                changeIntroStatus();
                mSelectedPosition + 1 == IntroList.introData.length
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => App()),
                      )
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
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setBool('intro', false);
  }
}
