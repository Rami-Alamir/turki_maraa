import 'package:flutter/material.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../widgets/shared/primary_app_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Policies extends StatelessWidget {
  final Map<String, String> policiesData;

  const Policies({Key? key, required this.policiesData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(
        title: AppLocalizations.of(context)!.tr(policiesData['title']!),
      ),
      body: WebView(
        initialUrl: policiesData['url'],
      ),
    );
  }
}
