import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';

class DrawerProvider with ChangeNotifier {
  final advancedDrawerController = AdvancedDrawerController();
  final bool _disabledGestures = true;

  bool get disabledGestures => _disabledGestures;

  void showDrawer() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    advancedDrawerController.showDrawer();
  }

  void hideDrawer() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    advancedDrawerController.hideDrawer();
  }

  void navigateTo(BuildContext context, String routeName) {
    Navigator.pushNamed(context, routeName);
    advancedDrawerController.hideDrawer();
  }
}
