import 'package:flutter/material.dart';
import '../shared/rounded_rectangle_button.dart';
import '../../../core/constants/fixed_assets.dart';
import '../../../core/utilities/app_localizations.dart';

class SpecialMessageDialog extends StatelessWidget {
  const SpecialMessageDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      backgroundColor: Theme.of(context).colorScheme.background,
      elevation: 0,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                FixedAssets.almaraaIcon,
                width: 120,
                height: 120,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: Text(
                  AppLocalizations.of(context)!.tr('dear_customers'),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        fontSize: 16,
                      ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              AppLocalizations.of(context)!.tr('eid_msgُ'),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  fontSize: 14, fontWeight: FontWeight.w500, height: 1.5),
            ),
          ),
          RoundedRectangleButton(
              title: AppLocalizations.of(context)!.tr('done'),
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
