import 'package:flutter/material.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:provider/provider.dart';

import '../shared/rounded_rectangle_button.dart';

class MessageDialog extends StatelessWidget {
  final String message;

  const MessageDialog({required this.message});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Container(
        width: 350,
        constraints: BoxConstraints(minHeight: 180, maxWidth: 350),
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 30),
              child: Container(
                width: 220,
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                      height: 1.4, fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            RoundedRectangleButton(
                title: AppLocalizations.of(context)!.tr('ok'),
                fontSize: 14,
                height: 42,
                width: 200,
                padding: EdgeInsets.only(top: 15),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
          ],
        ),
      ),
    );
  }
}
