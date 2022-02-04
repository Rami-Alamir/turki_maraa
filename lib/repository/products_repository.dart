import 'package:new_turki/models/best_seller.dart';
import 'package:new_turki/models/product.dart';
import 'package:new_turki/models/products.dart';
import 'package:new_turki/networking/api_base_helper.dart';

class ProductsRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  //get Products list
  Future<Products> getProductsList(String categoryId) async {
    print("getProductsList");
    print(categoryId);
    final response = await _helper.get("products/by-category/$categoryId");
    Products? products;
    try {
      products = Products.fromJson(response);
    } catch (e) {
      print(e.toString());
    }
    return products!;
  }

  //get Product data
  Future<Product> getProduct(String productId) async {
    print("getProductData");
    final response;
    Product? product;
    try {
      response = await _helper.get("products/$productId");
      print(response.toString());
      product = Product.fromJson(response);
    } catch (e) {
      print(e.toString());
    }
    return product!;
  }

  //get Best Seller
  Future<BestSeller> getBestSeller() async {
    print("getBestSeller");
    final response;
    BestSeller? bestSeller;
    try {
      response = await _helper.get("products/best-seller");
      print(response.toString());
      bestSeller = BestSeller.fromJson(response);
    } catch (e) {
      print('getBestSeller error');
      print(e.toString());
    }
    return bestSeller!;
  }
}
