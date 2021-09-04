import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:new_turki/screens/profile/notification.dart';

class AppProvider with ChangeNotifier {
  late BuildContext _context;

  set context(BuildContext value) {
    _context = value;
  }

  final advancedDrawerController = AdvancedDrawerController();
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

  void navigateTo(route) {
    Navigator.push(
      _context,
      MaterialPageRoute(builder: (context) => route),
    );
    advancedDrawerController.hideDrawer();
  }
}
