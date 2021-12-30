import 'package:new_turki/models/products.dart';
import 'package:new_turki/networking/api_base_helper.dart';

class ProductsRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  //get Products list
  Future<Products> getProductsList(String categoryId) async {
    print("getProductsList");
    final response = await _helper.get("products/by-subcategory/$categoryId");
    Products? products;
    try {
      products = Products.fromJson(response);
    } catch (e) {
      print(e.toString());
    }
    return products!;
  }
}
