import 'package:flutter/material.dart';
import '../../../core/constants/fixed_assets.dart';

class Logo extends StatelessWidget {
  final int type;
  final double width;
  final double height;

  const Logo({super.key, this.type = 2, this.width = 200, this.height = 30});
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      type == 2 ? FixedAssets.appName : FixedAssets.turkiLogoHome,
      width: width,
      height: height,
    );
  }
}
