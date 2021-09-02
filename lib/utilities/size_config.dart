import 'package:flutter/widgets.dart';

class SizeConfig {
  static MediaQueryData? _mediaQuery;
  static double? screenWidth;
  static double? screenHeight;

  void init(BuildContext context) {
    if (_mediaQuery == null) {
      _mediaQuery = MediaQuery.of(context);
      screenWidth = _mediaQuery?.size.width;
      screenHeight = _mediaQuery?.size.height;
    }
  }
}
