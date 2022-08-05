import 'dart:io';
import 'package:flutter/material.dart';
import 'package:new_turki/screens/app/app.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:new_turki/widgets/shared/rounded_rectangle_button.dart';

class NoInternet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset('assets/images/no_internet.gif'),
          Text(AppLocalizations.of(context)!.tr('no_internet_connection'),
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.headline4!.copyWith(
                  color: Color.fromRGBO(107, 0, 0, 1),
                  fontSize: 16,
                  fontWeight: FontWeight.w600)),
          Padding(
            padding: EdgeInsets.only(top: SizeConfig.screenHeight! / 5),
            child: RoundedRectangleButton(
                title: AppLocalizations.of(context)!.tr('try_again'),
                onPressed: () {
                  navigate(context);
                }),
          )
        ],
      ),
    );
  }

  void navigate(BuildContext context) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => App()),
            (Route<dynamic> route) => false);
      }
    } on SocketException catch (e) {
      print(e.toString());
    }
  }
}
