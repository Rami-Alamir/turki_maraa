import 'package:flutter/material.dart';
import '../../../core/constants/constants.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../widgets/shared/primary_app_bar.dart';

class HuaweiAppGallery extends StatelessWidget {
  const HuaweiAppGallery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PrimaryAppBar(
        title: '',
      ),
      body: WebView(
        initialUrl:
            'https://appgallery.cloud.huawei.com/marketshare/app/C102802029',
      ),
    );
  }
}
