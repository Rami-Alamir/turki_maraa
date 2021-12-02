import 'package:flutter/material.dart';
import 'package:new_turki/dummy_data/dummy_data.dart';
import 'package:new_turki/models/cart.dart';

class CartProvider with ChangeNotifier {
  bool _isLoading = true;
  bool _retry = false;

  Cart? _cartData;
  bool get isLoading => _isLoading;
  bool get retry => _retry;

  Cart get cartData => _cartData!;

  Future<void> getCartData() async {
    await Future.delayed(Duration(milliseconds: 2500), () {
      _cartData = DummyData.cart;
      _isLoading = false;
      notifyListeners();
    });
  }

  Future<void> reInitOrdersList() async {
    await Future.delayed(Duration(milliseconds: 1500), () {
      _cartData = DummyData.cart;
      _isLoading = false;
      notifyListeners();
    });
  }
}
