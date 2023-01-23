import 'package:flutter/widgets.dart';
import 'enum/device_screen_type.dart';

class SizeConfig {
  static MediaQueryData? _mediaQuery;
  static double? screenWidth;
  static double? screenHeight;
  static double? safeAreaHorizontal;
  static double? safeAreaVertical;
  static DeviceScreenType? deviceScreenType;
  static double statusBarHeight = 50;
  static double homeAppBarHeight = 200;

  void init(BuildContext context, {bool init = false}) {
    if (_mediaQuery == null || init) {
      _mediaQuery = MediaQuery.of(context);
      screenWidth = _mediaQuery?.size.width;
      screenHeight = _mediaQuery?.size.height;
      safeAreaHorizontal = (_mediaQuery?.padding.left ?? 0.0) +
          (_mediaQuery?.padding.right ?? 0.0);
      safeAreaVertical = (_mediaQuery?.padding.top ?? 0.0) +
          (_mediaQuery?.padding.bottom ?? 0.0);
      deviceScreenType = getDeviceScreenType();
      statusBarHeight = MediaQuery.of(context).padding.top;
      homeAppBarHeight = statusBarHeight + 153;
      if (homeAppBarHeight < 200) {
        homeAppBarHeight = 200;
      }
    }
  }

  static DeviceScreenType getDeviceScreenType() {
    double deviceWidth = 0;
    deviceWidth = _mediaQuery!.size.width;
    if (deviceWidth > 950) {
      return DeviceScreenType.desktop;
    } else if (deviceWidth > 570) {
      return DeviceScreenType.tablet;
    }
    return DeviceScreenType.mobile;
  }

  static double setWidgetHeightWithFactor(
      double mobile, double tablet, double desktop) {
    switch (deviceScreenType) {
      case DeviceScreenType.desktop:
        return screenHeight! * desktop;
      case DeviceScreenType.tablet:
        return screenHeight! * tablet;
      default:
        return screenHeight! * mobile;
    }
  }

  static double setWidgetHeight(double mobile, double tablet, double desktop) {
    switch (deviceScreenType) {
      case DeviceScreenType.desktop:
        return desktop;
      case DeviceScreenType.tablet:
        return tablet;
      default:
        return mobile;
    }
  }

  static double setWidgetWidthWithFactor(
      double mobile, double tablet, double desktop) {
    switch (deviceScreenType) {
      case DeviceScreenType.desktop:
        return screenWidth! * desktop;
      case DeviceScreenType.tablet:
        return screenWidth! * tablet;
      default:
        return screenWidth! * mobile;
    }
  }

  static double setWidgetWidth(double mobile, double tablet, double desktop) {
    switch (deviceScreenType) {
      case DeviceScreenType.desktop:
        return desktop;
      case DeviceScreenType.tablet:
        return tablet;
      default:
        return mobile;
    }
  }
}
