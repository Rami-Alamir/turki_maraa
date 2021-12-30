import 'package:new_turki/models/category_data.dart';
import 'package:new_turki/networking/api_base_helper.dart';

class HomeRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  //get Categories list
  Future<CategoryData> getCategoriesList() async {
    print("getCategoriesList");
    final response = await _helper.get("categories");
    CategoryData? categoryData;
    try {
      categoryData = CategoryData.fromJson(response);
    } catch (e) {
      print(e.toString());
    }
    return categoryData!;
  }
}
