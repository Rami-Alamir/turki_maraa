import 'package:flutter/material.dart';
import '../core/service/service_locator.dart';
import '../core/utilities/enum/request_status.dart';
import '../models/order.dart';
import '../models/orders_data.dart';
import '../repository/order_repository.dart';

class OrdersProvider with ChangeNotifier {
  bool _isAuth = false;
  OrdersData? _ordersData;
  Order? _order;
  String? _accessToken;
  RequestStatus _requestStatus = RequestStatus.isLoading;
  RequestStatus _requestStatus2 = RequestStatus.isLoading;

  OrdersData? get ordersData => _ordersData;
  Order get order => _order!;
  bool get isAuth => _isAuth;
  RequestStatus get requestStatus => _requestStatus;
  RequestStatus get requestStatus2 => _requestStatus2;

  void updateOrderProvider(String accessToken, bool isAuth) {
    _accessToken = accessToken;
    _isAuth = isAuth;
    if (_isAuth &&
        _ordersData == null) {
      notifyListeners();
      getOrdersList();
    } else if (!_isAuth) {
      _ordersData = null;
      _order = null;
      _requestStatus= RequestStatus.completed;
      notifyListeners();
    }
  }

  Future<void> getOrdersList({bool notify = false}) async {
    print('getOrdersList');
    if (_isAuth) {
      _requestStatus= RequestStatus.isLoading;
      if(notify){
        notifyListeners();
      }
      try {
        _ordersData =
            await sl<OrderRepository>().getOrdersList("Bearer $_accessToken");
        _requestStatus= RequestStatus.completed;
      } catch (_) {
        _requestStatus= RequestStatus.error;
      }
      notifyListeners();
    }
  }

  Future<void> getOrderData(String id,{bool notify = false}) async {
    _requestStatus2= RequestStatus.isLoading;
    if(notify){
      notifyListeners();
    }
    try {
      _order = await sl<OrderRepository>().getOrderData(
          id,
          ""
          "Bearer $_accessToken");
      _requestStatus2= RequestStatus.completed;

    } catch (_) {
      _requestStatus2= RequestStatus.error;
    }
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
