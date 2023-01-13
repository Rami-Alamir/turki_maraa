import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/cart_data.dart';
import '../core/service/networking/api_base_helper.dart';

class CartRepository {
  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<int> addToCart(
      body, String authorization, LatLng latLng, String countryId) async {
    final response = await _helper.post2(
        "carts/add-to-cart-v2?longitude=${latLng.longitude}&latitude=${latLng.latitude}&countryId=$countryId",
        body,
        authorization: authorization);
    return response;
  }

  Future<int> updateCartItem(body, String authorization, String id,
      LatLng latLng, String countryId) async {
    final response = await _helper.post2(
        "carts/update-cart/$id?longitude=${latLng.longitude}&latitude=${latLng.latitude}&countryId=$countryId",
        body,
        authorization: authorization);
    return response;
  }

  Future<int> deleteCartItem(
      String authorization, String id, LatLng latLng, String countryId) async {
    final response = await _helper.delete(
        "carts/delete-cart/$id?longitude=${latLng.longitude}&latitude=${latLng.latitude}&countryId=$countryId",
        authorization: authorization);
    return response;
  }

  Future<CartData> getCartList(
      String authorization, LatLng latLng, String countryId) async {
    final response = await _helper.get(
        "carts?page=1&per_page=500&longitude=${latLng.longitude}&latitude=${latLng.latitude}&countryId=$countryId",
        authorization: authorization);
    CartData? cartData;
    try {
      cartData = CartData.fromJson(response);
    } catch (_) {}
    return cartData!;
  }

  Future<int> checkCoupon(
      LatLng latLng, String countryId, body, String authorization) async {
    final response = await _helper.post2(
        "carts/check-coupon?longitude=${latLng.longitude}&latitude=${latLng.latitude}&countryId=$countryId",
        body,
        authorization: authorization);
    return response;
  }
}
