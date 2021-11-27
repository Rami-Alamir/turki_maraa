import 'package:flutter/material.dart';
import 'package:new_turki/models/user.dart';
import 'package:new_turki/utilities/app_localizations.dart';

class Auth with ChangeNotifier {
  User _user = User(
      name: 'رامي الأمير',
      phone: '0580809976',
      lng: 1.0,
      lat: 1.0,
      orders: 6,
      credit: 100.6,
      category: 'الفئة الفضية',
      point: 6500);
  bool? _isAuth = true;

  User get user => _user;

  bool get isAuth => _isAuth!;

  void logOut() {
    _user = User();
    _isAuth = false;
    notifyListeners();
  }

  void redeemPoints(BuildContext context, int point) {
    String msg;
    if (point > user.point!.toInt())
      msg =
          AppLocalizations.of(context)!.tr('your_points_balance_is_not_enough');
    else {
      msg = AppLocalizations.of(context)!
          .tr('your_points_have_been_successfully_redeemed');
      _user.point = (_user.point)! - (point * 1.0);
      notifyListeners();
    }

    final snackBar = SnackBar(
        content: Text(
      msg,
      textAlign: TextAlign.center,
    ));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
