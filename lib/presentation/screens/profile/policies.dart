import 'package:flutter/material.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../widgets/shared/primary_app_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Policies extends StatefulWidget {
  final Map<String, String> policiesData;

  const Policies({Key? key, required this.policiesData}) : super(key: key);
  @override
  PoliciesState createState() => PoliciesState();
}

class PoliciesState extends State<Policies> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(
        title: AppLocalizations.of(context)!.tr(widget.policiesData['title']!),
      ),
      body: WebView(
        initialUrl: widget.policiesData['url'],
      ),
    );
  }
}
