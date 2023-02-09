import 'package:flutter/material.dart';
import '../../../core/constants/constants.dart';
import '../../../core/utilities/app_localizations.dart';
import 'text_button.dart';

class ProfileFooter extends StatelessWidget {
  const ProfileFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle =
        Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 10);
    return Padding(
      padding: const EdgeInsets.only(bottom: 50.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const TextBtn(
                  title: 'privacy_policy', url: Constants.privacyPolicy),
              Text(' |    ', textAlign: TextAlign.center, style: textStyle),
              const TextBtn(title: 'terms_of_use', url: Constants.terms),
            ],
          ),
          Text('V${Constants.appVersion}',
              textAlign: TextAlign.center, style: textStyle),
          const SizedBox(height: 15),
          Text(AppLocalizations.of(context)!.tr('all_rights_reserved'),
              textAlign: TextAlign.center, style: textStyle),
        ],
      ),
    );
  }
}
