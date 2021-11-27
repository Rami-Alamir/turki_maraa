import 'package:flutter/material.dart';
import 'package:new_turki/dummy_data/dummy_data.dart';
import 'package:new_turki/models/order.dart';

class OrdersProvider with ChangeNotifier {
  bool _isLoading = true;
  bool _retry = false;
  List<Order> _ordersList = [];

  bool get retry => _retry;

  List<Order> get ordersList => _ordersList;

  bool get isLoading => _isLoading;

  Future<void> getOrdersList() async {
    await Future.delayed(Duration(milliseconds: 5500), () {
      _ordersList = DummyData.ordersList;
      _isLoading = false;
      notifyListeners();
    });
  }

  Future<void> reInitOrdersList() async {
    await Future.delayed(Duration(milliseconds: 1500), () {
      _ordersList = DummyData.ordersList;
      _isLoading = false;
      notifyListeners();
    });
  }
}
