import 'package:flutter/material.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:new_turki/widgets/shared/rounded_rectangle_button.dart';

class Success extends StatelessWidget {
  final String title;

  const Success({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(20, 190, 100, 1),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 180.0),
            child: Column(
              children: [
                Image.asset(
                  'assets/images/success.gif',
                  width: SizeConfig.screenWidth,
                  fit: BoxFit.fill,
                ),
                Text(
                  AppLocalizations.of(context)!.tr(title),
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      height: 3),
                ),
              ],
            ),
          ),
          RoundedRectangleButton(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 50),
              title: AppLocalizations.of(context)!.tr('done'),
              color: Color.fromRGBO(28, 210, 116, 1),
              onPressed: () {
                Navigator.pop(context);
              })
        ],
      ),
    );
  }
}
