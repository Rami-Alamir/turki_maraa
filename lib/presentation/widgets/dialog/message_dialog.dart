import 'package:flutter/material.dart';
import '../shared/rounded_rectangle_button.dart';
import '../../../core/constants/fixed_assets.dart';
import '../../../core/utilities/app_localizations.dart';

class MessageDialog extends StatelessWidget {
  final String message;
  final String image;

  const MessageDialog({Key? key, required this.message, required this.image})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      backgroundColor: Theme.of(context).colorScheme.background,
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
                FixedAssets.warning,
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
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    fontSize: 14,
                  ),
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
