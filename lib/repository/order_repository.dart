import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:new_turki/models/order.dart';
import 'package:new_turki/models/orders_data.dart';
import 'package:new_turki/networking/api_base_helper.dart';

class OrderRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  //place Order
  Future<int> placeOrder(
      body, String authorization, LatLng latLng, String countryId) async {
    final response = await _helper.post4(
        "orders/add-order?longitude=${latLng.longitude}&latitude=${latLng.latitude}&countryId=$countryId",
        json.encode(body),
        authorization: authorization);
    return response;
  }

  //get Orders list
  Future<OrdersData> getOrdersList(String authorization) async {
    final response = await _helper.get("orders", authorization: authorization);
    OrdersData? ordersData;
    try {
      ordersData = OrdersData.fromJson(response);
      print(response.toString());
    } catch (e) {
      print(e.toString());
    }
    return ordersData!;
  }

  //get Order data
  Future<Order> getOrderData(String id, String authorization) async {
    final response =
        await _helper.get("orders/$id", authorization: authorization);
    Order? orderData;
    try {
      orderData = Order.fromJson(response);
    } catch (e) {
      print(e.toString());
    }
    return orderData!;
  }
}
