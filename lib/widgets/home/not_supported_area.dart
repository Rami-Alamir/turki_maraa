import 'package:flutter/material.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/size_config.dart';

class NotSupportedArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50.0),
      child: Container(
        width: SizeConfig.screenWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.asset('assets/images/not_supported.png',
                  width: 200, height: 200),
            ),
            SizedBox(
              width: SizeConfig.screenWidth! * .7,
              child: Text(
                AppLocalizations.of(context)!.tr('not_supported_area'),
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(fontSize: 16, height: 2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
