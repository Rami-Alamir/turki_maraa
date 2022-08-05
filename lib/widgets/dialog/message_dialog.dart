import 'package:flutter/material.dart';

import '../../../utilities/app_localizations.dart';
import '../shared/rounded_rectangle_button.dart';

class MessageDialog extends StatelessWidget {
  final String message;
  final String image;

  const MessageDialog({required this.message, required this.image});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      backgroundColor: Theme.of(context).splashColor,
      elevation: 0,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/warning.png',
                width: 80,
                height: 80,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
          RoundedRectangleButton(
              title: AppLocalizations.of(context)!.tr('confirm'),
              fontSize: 14,
              height: 42,
              padding: const EdgeInsets.only(top: 15),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ],
      ),
    );
  }
}
