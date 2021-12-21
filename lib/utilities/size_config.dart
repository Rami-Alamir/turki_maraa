import 'package:flutter/widgets.dart';

enum DeviceScreenType { Mobile, Tablet, Desktop }

class SizeConfig {
  static MediaQueryData? _mediaQuery;
  static double? screenWidth;
  static double? screenHeight;
  static double? safeAreaHorizontal;
  static double? safeAreaVertical;
  static DeviceScreenType? deviceScreenType;

  void init(BuildContext context) {
    if (_mediaQuery == null) {
      _mediaQuery = MediaQuery.of(context);
      screenWidth = _mediaQuery?.size.width;
      screenHeight = _mediaQuery?.size.height;
      safeAreaHorizontal = (_mediaQuery?.padding.left ?? 0.0) +
          (_mediaQuery?.padding.right ?? 0.0);
      safeAreaVertical = (_mediaQuery?.padding.top ?? 0.0) +
          (_mediaQuery?.padding.bottom ?? 0.0);
      deviceScreenType = getDeviceScreenType();
    }
  }

  static DeviceScreenType getDeviceScreenType() {
    var orientation = _mediaQuery?.orientation;
    double deviceWidth = 0;
    if (orientation == Orientation.landscape) {
      deviceWidth = _mediaQuery!.size.height;
    } else {
      deviceWidth = _mediaQuery!.size.width;
    }
    if (deviceWidth > 950) {
      return DeviceScreenType.Desktop;
    } else if (deviceWidth > 600) {
      return DeviceScreenType.Tablet;
    }
    return DeviceScreenType.Mobile;
  }

  static double setWidgetHeightWithFactor(
      double mobile, double tablet, double desktop) {
    switch (deviceScreenType) {
      case DeviceScreenType.Desktop:
        return screenHeight! * desktop;
      case DeviceScreenType.Tablet:
        return screenHeight! * tablet;
      default:
        return screenHeight! * mobile;
    }
  }

  static double setWidgetHeight(double mobile, double tablet, double desktop) {
    switch (deviceScreenType) {
      case DeviceScreenType.Desktop:
        return desktop;
      case DeviceScreenType.Tablet:
        return tablet;
      default:
        return mobile;
    }
  }

  static double setWidgetWidthWithFactor(
      double mobile, double tablet, double desktop) {
    switch (deviceScreenType) {
      case DeviceScreenType.Desktop:
        return screenWidth! * desktop;
      case DeviceScreenType.Tablet:
        return screenWidth! * tablet;
      default:
        return screenWidth! * mobile;
    }
  }

  static double setWidgetWidth(double mobile, double tablet, double desktop) {
    switch (deviceScreenType) {
      case DeviceScreenType.Desktop:
        return desktop;
      case DeviceScreenType.Tablet:
        return tablet;
      default:
        return mobile;
    }
  }
}
