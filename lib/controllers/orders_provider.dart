import 'package:flutter/material.dart';
import '../core/service/service_locator.dart';
import '../models/order.dart';
import '../models/orders_data.dart';
import '../repository/order_repository.dart';

class OrdersProvider with ChangeNotifier {
  bool? _isLoading;
  bool _retry = false;
  bool _isAuth = false;
  bool _isLoading2 = true;
  bool _retry2 = false;
  OrdersData? _ordersData;
  Order? _order;
  String? _accessToken;

  OrdersData? get ordersData => _ordersData;
  Order get order => _order!;
  bool get retry => _retry;
  bool get retry2 => _retry2;
  bool get isLoading => _isLoading == true;
  bool get isLoading2 => _isLoading2;
  bool get isAuth => _isAuth;

  set setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  set setIsLoading2(bool value) {
    _isLoading2 = value;
    notifyListeners();
  }

  void updateOrderProvider(String accessToken, bool isAuth) {
    _accessToken = accessToken;
    _isAuth = isAuth;
    if (_isAuth &&
        _ordersData == null &&
        (_isLoading == false || _isLoading == null)) {
      notifyListeners();
      getOrdersList();
    } else if (!_isAuth) {
      _ordersData = null;
      _order = null;
      _isLoading = false;
      notifyListeners();
    }
  }

  //get orders list Data
  Future<void> getOrdersList() async {
    if (_isAuth) {
      _isLoading = true;
      _retry = false;
      try {
        _ordersData =
            await sl<OrderRepository>().getOrdersList("Bearer $_accessToken");
      } catch (_) {
        _retry = true;
      }
      _isLoading = false;
      notifyListeners();
    }
  }

  //get order Data
  Future<void> getOrderData(String id) async {
    _isLoading2 = true;
    _retry2 = false;
    try {
      _order = await sl<OrderRepository>().getOrderData(
          id,
          ""
          "Bearer $_accessToken");
    } catch (_) {
      _retry2 = true;
    }
    _isLoading2 = false;
    notifyListeners();
  }

  // calculate order items
  int orderItems({int index = -1}) {
    int count = 0;
    if (index == -1) {
      for (int i = 0; i < _order!.data!.orderProducts!.length; i++) {
        count += _order!.data!.orderProducts![i].quantity!;
      }
    } else {
      for (int i = 0; i < _ordersData!.data![index].products!.length; i++) {
        count += _ordersData!.data![index].orderProducts![i].quantity!;
      }
    }
    return count;
  }
}
