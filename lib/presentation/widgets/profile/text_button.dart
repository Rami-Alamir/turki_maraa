import 'package:flutter/material.dart';
import '../../../core/constants/route_constants.dart';
import '../../../core/service/firebase_helper.dart';
import '../../../core/utilities/app_localizations.dart';

class TextBtn extends StatelessWidget {
  final String title;
  final String url;
  const TextBtn({Key? key, required this.title, required this.url})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        overlayColor:
            MaterialStateColor.resolveWith((states) => Colors.transparent),
      ),
      onPressed: () {
        FirebaseHelper().pushAnalyticsEvent(name: "policies", value: title);
        Navigator.pushNamed(context, policies,
            arguments: {"url": url, "title": title});
      },
      child: Text(AppLocalizations.of(context)!.tr(title),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline5!.copyWith(fontSize: 10)),
    );
  }
}
