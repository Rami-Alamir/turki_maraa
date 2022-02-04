import 'package:new_turki/models/banners_data.dart';
import 'package:new_turki/models/category_data.dart';
import 'package:new_turki/models/discover_item.dart';
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

  //get Banners list
  Future<BannersData> getBannersList(int categoryId) async {
    print("getBannersList");

    final response = await _helper.get("banners/by-category/$categoryId");
    BannersData? bannersData;
    try {
      bannersData = BannersData.fromJson(response);
    } catch (e) {
      print('BannersData error');
      print(e.toString());
    }
    return bannersData!;
  }

  //get Discover data
  Future<DiscoverItem> getDiscover(int categoryId) async {
    print("getDiscover");
    final response =
        await _helper.get("filters/by-category/$categoryId?active=1");
    DiscoverItem? discoverItem;
    try {
      discoverItem = DiscoverItem.fromJson(response);
    } catch (e) {
      print(e.toString());
    }
    return discoverItem!;
  }
}
