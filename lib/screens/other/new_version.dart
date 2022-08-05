import 'dart:io';
import 'package:flutter/material.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:new_turki/widgets/shared/rounded_rectangle_button.dart';
import 'package:url_launcher/url_launcher_string.dart';

class NewVersion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: SizeConfig.screenWidth,
        height: SizeConfig.screenHeight,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/ww1.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: SizeConfig.screenHeight! * 0.2),
              child: Image.asset(
                'assets/images/turki_icon.png',
                width: 200,
                height: 200,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: SizeConfig.screenHeight! * 0.15, bottom: 15),
              child: Text(AppLocalizations.of(context)!.tr('new_update'),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                      color: Color.fromRGBO(236, 204, 120, 1),
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              width: SizeConfig.screenWidth! * 0.85,
              child: Text(AppLocalizations.of(context)!.tr('new_update_desc'),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                      color: Color.fromRGBO(236, 204, 99, 1),
                      height: 1.5,
                      fontSize: 16,
                      fontWeight: FontWeight.w300)),
            ),
            Expanded(
              flex: 1,
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: RoundedRectangleButton(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                  title: AppLocalizations.of(context)!.tr('update_now'),
                  onPressed: () async {
                    await _launchURL(Platform.isIOS
                        ? "https://apps.apple.com/us/app/%D8%AA%D8%B1%D9%83%D9%8A-%D9%84%D9%84%D8%B0%D8%A8%D8%A7%D8%A6%D8%AD/id1115628569"
                        : "https://play.google.com/store/apps/details?id=com.digishapes.turkieshop&hl=ar&gl=US");
                  },
                  fontSize: 24,
                  fontColor: Color.fromRGBO(236, 204, 120, 1),
                  color: Color.fromRGBO(90, 4, 20, 1),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  //used to make calls, whatsapp
  _launchURL(String url) async {
    try {
      if (await canLaunchUrlString(url)) {
        await launchUrlString(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
