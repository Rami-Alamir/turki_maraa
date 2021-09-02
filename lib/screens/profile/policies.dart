import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

class Policies extends StatefulWidget {
  final String url;
  final String title;

  const Policies({required this.url, required this.title});
  @override
  _PoliciesState createState() => _PoliciesState();
}

class _PoliciesState extends State<Policies> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
        initialUrl: widget.url,
        //body:Container(
      ),
    );
  }
}
