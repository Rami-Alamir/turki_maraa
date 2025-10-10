import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/order.dart';
import '../models/orders_data.dart';
import '../core/service/networking/api_base_helper.dart';
import '../core/service/service_locator.dart';

class OrderRepository {
  final ApiBaseHelper _helper = sl<ApiBaseHelper>();

  Future<dynamic> placeOrder(
    body,
    String authorization,
    LatLng latLng,
    String countryId,
  ) async {
    final response = await _helper.post4(
      "orders/add-order?longitude=${latLng.longitude}&latitude=${latLng.latitude}&countryId=$countryId",
      json.encode(body),
      authorization: authorization,
    );
    return response;
  }

  Future<OrdersData> getOrdersList(String authorization) async {
    final response = await _helper.get(
      "orders/get-order",
      authorization: authorization,
    );
    OrdersData ordersData;
    ordersData = OrdersData.fromJson(response);
    return ordersData;
  }

  Future<OrderModel> getOrderData(String id, String authorization) async {
    final response = await _helper.get(
      "orders/get-one-order/$id",
      authorization: authorization,
    );
    OrderModel? orderData;
    orderData = OrderModel.fromJson(response);
    return orderData;
  }
}
