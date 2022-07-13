import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:new_turki/models/best_seller.dart';
import 'package:new_turki/models/product.dart';
import 'package:new_turki/models/products.dart';
import 'package:new_turki/networking/api_base_helper.dart';

class ProductsRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  //get Products list
  Future<Products> getProductsList(
      String categoryId, LatLng latLng, String countryId) async {
    print("getProductsList");
    print(categoryId);

    final response = await _helper.get(
        "products/by-category/$categoryId?longitude=${latLng.longitude}&latitude=${latLng.latitude}&countryId=$countryId");
    Products? products;
    try {
      products = Products.fromJson(response);
    } catch (e) {
      print(e.toString());
    }
    return products!;
  }

  //get Product data
  Future<Product> getProduct(
      String productId, LatLng latLng, String countryId) async {
    print("getProductData ");
    print(
        "products/getProduct/$productId?longitude=${latLng.longitude}&latitude=${latLng.latitude}&countryId=$countryId");
    final response;
    Product? product;
    try {
      response = await _helper.get(
          "products/getProduct/$productId?longitude=${latLng.longitude}&latitude=${latLng.latitude}&countryId=$countryId");
      print("getProductData ");

      print(response.toString());
      product = Product.fromJson(response);
    } catch (e) {
      print(e.toString());
    }
    return product!;
  }

  //get Best Seller
  Future<BestSeller> getBestSeller(LatLng latLng, String countryId) async {
    print("getBestSeller");
    final response;
    BestSeller? bestSeller;
    try {
      response = await _helper.get(
          "products/best-seller?longitude=${latLng.longitude}&latitude=${latLng.latitude}&countryId=$countryId");
      print(response.toString());
      bestSeller = BestSeller.fromJson(response);
    } catch (e) {
      print('getBestSeller error');
      print(e.toString());
    }
    return bestSeller!;
  }
}
