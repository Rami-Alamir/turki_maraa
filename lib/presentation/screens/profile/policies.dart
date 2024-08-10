import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../widgets/shared/primary_app_bar.dart';
import '../../../core/utilities/app_localizations.dart';

class Policies extends StatefulWidget {
  final Map<String, String> policiesData;

  const Policies({super.key, required this.policiesData});

  @override
  State<Policies> createState() => _PoliciesState();
}

class _PoliciesState extends State<Policies> {
  bool loading = true;
  final WebViewController _webViewController = WebViewController();

  @override
  void initState() {
    super.initState();
    _webViewController
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.policiesData['url'] ?? ""))
      ..setNavigationDelegate(NavigationDelegate(onPageFinished: (page) async {
        if (mounted) {
          setState(() {
            loading = false;
          });
        }
      }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(
        title: AppLocalizations.of(context)!.tr(widget.policiesData['title']!),
      ),
      body: WebViewWidget(
        controller: _webViewController,
      ),
    );
  }
}
