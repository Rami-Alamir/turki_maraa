import 'package:flutter/material.dart';
import '../../../core/constants/fixed_assets.dart';

class Logo extends StatelessWidget {
  final int type;

  const Logo({Key? key, this.type = 2}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      FixedAssets.appName,
      width: 200,
      height: 30,
    );
  }
}
