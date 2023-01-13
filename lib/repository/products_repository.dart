import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/best_seller.dart';
import '../models/product_details.dart';
import '../models/product.dart';
import '../core/service/networking/api_base_helper.dart';
import '../core/service/service_locator.dart';

class ProductsRepository {
  final ApiBaseHelper _helper = sl<ApiBaseHelper>();

  Future<Product> getProductsList(
      String categoryId, LatLng latLng, String countryId) async {
    final response = await _helper.get(
        "products/by-category/$categoryId?longitude=${latLng.longitude}&latitude=${latLng.latitude}&countryId=$countryId");
    Product? products;
    try {
      products = Product.fromJson(response);
    } catch (_) {}
    return products!;
  }

  Future<ProductDetails> getProduct(
      String productId, LatLng latLng, String countryId) async {
    final Map<String, dynamic> response;
    ProductDetails? product;
    try {
      response = await _helper.get(
          "products/getProduct/$productId?longitude=${latLng.longitude}&latitude=${latLng.latitude}&countryId=$countryId");
      product = ProductDetails.fromJson(response);
    } catch (_) {}
    return product!;
  }

  Future<BestSeller> getBestSeller(LatLng latLng, String countryId) async {
    final Map<String, dynamic> response;
    BestSeller? bestSeller;
    try {
      response = await _helper.get(
          "products/best-seller?longitude=${latLng.longitude}&latitude=${latLng.latitude}&countryId=$countryId");
      bestSeller = BestSeller.fromJson(response);
    } catch (_) {}
    return bestSeller!;
  }
}
