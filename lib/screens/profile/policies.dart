import 'package:flutter/material.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/widgets/shared/primary_app_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Policies extends StatefulWidget {
  final policiesData;

  const Policies({required this.policiesData});
  @override
  _PoliciesState createState() => _PoliciesState();
}

class _PoliciesState extends State<Policies> {
  @override
  Widget build(BuildContext context) {
    print(widget.policiesData.toString);

    return Scaffold(
      appBar: PrimaryAppBar(
        title: AppLocalizations.of(context)!.tr(widget.policiesData['title']!),
      ),
      body: WebView(
        initialUrl: widget.policiesData['url'],
        //body:Container(
      ),
    );
  }
}
