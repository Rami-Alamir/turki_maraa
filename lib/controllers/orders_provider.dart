import 'package:flutter/material.dart';
import '../core/service/service_locator.dart';
import '../core/utilities/enum/request_status.dart';
import '../models/order.dart';
import '../models/orders_data.dart';
import '../repository/order_repository.dart';

class OrdersProvider with ChangeNotifier {
  bool _isAuth = false;
  OrdersData? _ordersData;
  OrderModel? _order;
  String? _accessToken;
  RequestStatus _requestStatus = RequestStatus.isLoading;

  OrdersData? get ordersData => _ordersData;
  OrderModel? get order => _order;
  bool get isAuth => _isAuth;
  RequestStatus get requestStatus => _requestStatus;

  void updateOrderProvider(String accessToken, bool isAuth) {
    _accessToken = accessToken;
    _isAuth = isAuth;
    if (_isAuth && _ordersData == null) {
      notifyListeners();
      getOrdersList();
    } else if (!_isAuth) {
      _ordersData = null;
      _order = null;
      _requestStatus = RequestStatus.completed;
      notifyListeners();
    }
  }

  Future<void> getOrdersList({bool notify = false}) async {
    if (_isAuth) {
      _requestStatus = RequestStatus.isLoading;
      if (notify) {
        notifyListeners();
      }
      try {
        _ordersData =
            await sl<OrderRepository>().getOrdersList("Bearer $_accessToken");
        _requestStatus = RequestStatus.completed;
      } catch (_) {
        _requestStatus = RequestStatus.error;
      }
      notifyListeners();
    }
  }

  Future<(OrderModel?, RequestStatus)> getOrderData(String id,
      {bool notify = false}) async {
    RequestStatus requestStatus2 = RequestStatus.isLoading;
    if (notify) {
      notifyListeners();
    }
    OrderModel? order;
    try {
      order =
          await sl<OrderRepository>().getOrderData(id, "Bearer $_accessToken");
      requestStatus2 = RequestStatus.completed;
    } catch (_) {
      requestStatus2 = RequestStatus.error;
    }
    notifyListeners();
    return (order, requestStatus2);
  }
}
