import 'package:flutter/material.dart';
import 'package:new_turki/dummy_data/dummy_data.dart';
import 'package:new_turki/models/order.dart';

class OrdersProvider with ChangeNotifier {
  bool _isLoading = true;
  bool _isLoading2 = true;
  bool _retry = false;
  List<Order> _ordersList = [];
  Order? _order;

  Order get order => _order!;

  bool get retry => _retry;

  List<Order> get ordersList => _ordersList;

  bool get isLoading => _isLoading;
  bool get isLoading2 => _isLoading2;

  Future<void> getOrdersList() async {
    await Future.delayed(Duration(milliseconds: 2500), () {
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

  Future<void> getOrder() async {
    _isLoading2 = true;
    await Future.delayed(Duration(milliseconds: 500), () {
      _order = DummyData.ordersList[3];
      _isLoading2 = false;
      notifyListeners();
    });
  }
}
