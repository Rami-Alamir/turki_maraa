import 'package:flutter/material.dart';
import 'package:new_turki/utilities/app_localizations.dart';

class ProfileFooter extends StatelessWidget {
  final String version;

  const ProfileFooter({required this.version});

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle =
        Theme.of(context).textTheme.headline5!.copyWith(fontSize: 10);

    Widget _textButton(String title, String url) {
      return TextButton(
        style: ButtonStyle(
          overlayColor:
              MaterialStateColor.resolveWith((states) => Colors.transparent),
        ),
        onPressed: () => Navigator.pushNamed(context, '/Policies',
            arguments: {"url": url, "title": title}),
        child: Text(AppLocalizations.of(context)!.tr(title),
            textAlign: TextAlign.center, style: textStyle),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 50.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _textButton('privacy_policy',
                  'https://green-diet.herokuapp.com/privacy-policy'),
              Text('    |    ', textAlign: TextAlign.center, style: textStyle),
              _textButton('terms_of_use',
                  'https://green-diet.herokuapp.com/terms-of-use'),
            ],
          ),
          Visibility(
              visible: version.isNotEmpty,
              child: Text('V$version',
                  textAlign: TextAlign.center, style: textStyle)),
          SizedBox(height: 15),
          Text(AppLocalizations.of(context)!.tr('all_rights_reserved'),
              textAlign: TextAlign.center, style: textStyle),
        ],
      ),
    );
  }
}
