import 'package:flutter/material.dart';
import 'package:new_turki/models/order.dart';
import 'package:new_turki/models/orders_data.dart';
import 'package:new_turki/repository/order_repository.dart';

class OrdersProvider with ChangeNotifier {
  bool _isLoading = true;
  bool _retry = false;
  bool _isLoading2 = true;
  bool _retry2 = false;
  OrdersData? _ordersData;
  Order? _order;
  String? _token;

  OrdersData? get ordersData => _ordersData;
  Order get order => _order!;
  bool get retry => _retry;
  bool get retry2 => _retry2;
  bool get isLoading => _isLoading;
  bool get isLoading2 => _isLoading2;

  set setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  set setIsLoading2(bool value) {
    _isLoading2 = value;
    notifyListeners();
  }

  //get orders list Data
  Future<void> getOrdersList(String token) async {
    _token = token;
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

  //get order Data
  Future<void> getOrderData(String id) async {
    _isLoading2 = true;
    _retry2 = false;
    try {
      _order = await OrderRepository().getOrderData(
          id,
          ""
          "Bearer $_token");
    } catch (e) {
      print('catch order');
      print(e.toString());
      _retry2 = true;
    }
    _isLoading2 = false;
    notifyListeners();
  }
}
