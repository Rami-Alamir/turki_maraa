import 'package:flutter/material.dart';
import 'package:new_turki/models/orders_data.dart';
import 'package:new_turki/repository/order_repository.dart';

class OrdersProvider with ChangeNotifier {
  bool _isLoading = true;
  bool _retry = false;
  OrdersData? _ordersData;

  OrdersData? get ordersData => _ordersData;

  bool get retry => _retry;

  bool get isLoading => _isLoading;

  set setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  //getCartData
  Future<void> getOrdersList(String token) async {
    _isLoading = true;
    _retry = false;

    try {
      _ordersData = await OrderRepository().getOrdersList("Bearer $token");
    } catch (e) {
      print('catch cart');
      print(e.toString());
      _retry = true;
    }
    _isLoading = false;
    notifyListeners();
  }
}
