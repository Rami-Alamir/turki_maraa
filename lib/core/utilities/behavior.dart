import 'package:flutter/material.dart';

// used to remove scroll glow
class Behavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
