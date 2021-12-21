import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:new_turki/widgets/shared/rounded_rectangle_button.dart';
import 'package:url_launcher/url_launcher.dart';

class NewVersion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: SizeConfig.screenHeight! * 0.2),
            child: Image.asset(
              'assets/images/turki_icon.png',
              width: 150,
              height: 150,
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
                fontColor: Color.fromRGBO(236, 204, 120, 1),
                color: Color.fromRGBO(180, 0, 0, 0.2),
              ),
            ),
          )
        ],
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
