import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import '../../widgets/cart/my_fatoorah_appbar.dart';
import '../../widgets/shared/spinkit_indicator.dart';
import '../../../core/constants/route_constants.dart';

class MyFatoorahWebview extends StatefulWidget {
  final String url;

  const MyFatoorahWebview({super.key, required this.url});

  @override
  State<MyFatoorahWebview> createState() => _MyFatoorahWebviewState();
}

class _MyFatoorahWebviewState extends State<MyFatoorahWebview> {
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const MyFatoorahAppBar(),
      body: PopScope(
        canPop: false,
        child: SafeArea(
          child: Stack(
            children: [
              InAppWebView(
                onProgressChanged: (controller, progress) {
                  setState(() {
                    this.progress = progress / 100;
                  });
                },
                onGeolocationPermissionsShowPrompt:
                    (webViewController, origin) async {
                      return GeolocationPermissionShowPromptResponse(
                        allow: true,
                        origin: origin,
                        retain: true,
                      );
                    },
                initialSettings: InAppWebViewSettings(
                  supportZoom: false,
                  javaScriptEnabled: true,
                  allowFileAccess: true,
                  disableContextMenu: true,
                  mediaPlaybackRequiresUserGesture: false,
                ),
                onPageCommitVisible: (controller, url) async {
                  print(url);
                  bool paymentStatus = false;
                  if (url.toString().contains("almaraacompany")) {
                    try {
                      var data = await controller.evaluateJavascript(
                        source: "document.body.innerText",
                      );
                      if (data.contains("تمت عملية الدفع بنجاح")) {
                        paymentStatus = true;
                      }
                    } catch (_) {
                      paymentStatus = false;
                    }
                    if (context.mounted) {
                      Navigator.pushReplacementNamed(
                        context,
                        orderStatus,
                        arguments: paymentStatus,
                      );
                    }
                  }
                },
                onLoadStop: (controller, url) async {},
                initialUrlRequest: URLRequest(url: WebUri(widget.url)),
              ),
              if (progress < 1.0) const SpinkitIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
