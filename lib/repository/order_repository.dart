import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/order.dart';
import '../models/orders_data.dart';
import '../core/service/networking/api_base_helper.dart';

class OrderRepository {
  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<dynamic> placeOrder(
      body, String authorization, LatLng latLng, String countryId) async {
    final response = await _helper.post4(
        "orders/add-order?longitude=${latLng.longitude}&latitude=${latLng.latitude}&countryId=$countryId",
        json.encode(body),
        authorization: authorization);
    return response;
  }

  Future<OrdersData> getOrdersList(String authorization) async {
    final response = await _helper.get("orders", authorization: authorization);
    OrdersData? ordersData;
    try {
      ordersData = OrdersData.fromJson(response);
    } catch (_) {}
    return ordersData!;
  }

  Future<Order> getOrderData(String id, String authorization) async {
    final response =
        await _helper.get("orders/$id", authorization: authorization);
    Order? orderData;
    try {
      orderData = Order.fromJson(response);
    } catch (_) {}
    return orderData!;
  }
}
