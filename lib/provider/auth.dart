import 'package:flutter/material.dart';
import 'package:new_turki/models/user.dart';

class Auth with ChangeNotifier {
  User _user = User(
      name: 'رامي الأمير',
      phone: '0580809976',
      lng: 1.0,
      lat: 1.0,
      orders: 6,
      credit: 100.6,
      point: 3000);
  bool? _isAuth = true;

  User get user => _user;

  bool get isAuth => _isAuth!;

  void logOut() {
    _user = User();
    _isAuth = false;
    notifyListeners();
  }
}
