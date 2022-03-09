import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:new_turki/models/cart_data.dart';
import 'package:new_turki/networking/api_base_helper.dart';

class CartRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  //add to cart
  Future<int> addToCart(
      body, String authorization, LatLng latLng, String countryId) async {
    final response = await _helper.post2(
        "carts/add-to-cart?longitude=${latLng.longitude}&latitude=${latLng.latitude}&countryId=$countryId",
        body,
        authorization: authorization);
    return response;
  }

  //update cart
  Future<int> updateCartItem(body, String authorization, String id,
      LatLng latLng, String countryId) async {
    final response = await _helper.post2(
        "carts/update-cart/$id?longitude=${latLng.longitude}&latitude=${latLng.latitude}&countryId=$countryId",
        body,
        authorization: authorization);
    return response;
  }

  //delete cart item
  Future<int> deleteCartItem(
      String authorization, String id, LatLng latLng, String countryId) async {
    final response = await _helper.delete(
        "carts/delete-cart/$id?longitude=${latLng.longitude}&latitude=${latLng.latitude}&countryId=$countryId",
        authorization: authorization);
    return response;
  }

  //get cart list
  Future<CartData> getCartList(
      String authorization, LatLng latLng, String countryId) async {
    print(
        "carts?page=1&per_page=500&longitude=${latLng.longitude}&latitude=${latLng.latitude}&countryId=$countryId");
    final response = await _helper.get(
        "carts?page=1&per_page=500&longitude=${latLng.longitude}&latitude=${latLng.latitude}&countryId=$countryId",
        authorization: authorization);
    CartData? cartData;
    try {
      cartData = CartData.fromJson(response);
    } catch (e) {
      print(e.toString());
    }
    return cartData!;
  }

  //check coupon
  Future<int> checkCoupon(
      LatLng latLng, String countryId, body, String authorization) async {
    final response = await _helper.post2(
        "carts/check-coupon?longitude=${latLng.longitude}&latitude=${latLng.latitude}&countryId=$countryId",
        body,
        authorization: authorization);
    return response;
  }
}
