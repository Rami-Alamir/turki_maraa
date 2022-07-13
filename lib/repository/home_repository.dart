import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:new_turki/models/banners_data.dart';
import 'package:new_turki/models/category_data.dart';
import 'package:new_turki/models/discover_data.dart';
import 'package:new_turki/models/discover_item.dart';
import 'package:new_turki/networking/api_base_helper.dart';

class HomeRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  //get Categories list
  Future<CategoryData> getCategoriesList(
      LatLng latLng, String countryId) async {
    print("getCategoriesList");
    final response = await _helper.get(
        "categories/categories-app?longitude=${latLng.longitude}&latitude=${latLng.latitude}&countryId=$countryId");
    CategoryData? categoryData;
    try {
      categoryData = CategoryData.fromJson(response);
      print(response.toString());
    } catch (e) {
      print(e.toString());
    }
    return categoryData!;
  }

  //get Banners list
  Future<BannersData> getBannersList(
      int categoryId, LatLng latLng, String countryId) async {
    print("getBannersList");

    final response = await _helper.get(
        "banners/by-category/$categoryId?longitude=${latLng.longitude}&latitude=${latLng.latitude}&countryId=$countryId");
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
  Future<DiscoverData> getDiscover(
      int categoryId, LatLng latLng, String countryId) async {
    print("getDiscover");
    print(
        "${"filters/by-category/$categoryId?active=1&longitude=${latLng.longitude}&latitude=${latLng.latitude}&countryId=$countryId"}");
    final response = await _helper.get(
        "filters/by-category/$categoryId?active=1&longitude=${latLng.longitude}&latitude=${latLng.latitude}&countryId=$countryId");
    DiscoverData? discoverItem;
    try {
      discoverItem = DiscoverData.fromJson(response);
    } catch (e) {
      print(e.toString());
    }
    return discoverItem!;
  }

  //get Discover item data
  Future<DiscoverItem> getDiscoverItem(
      int id, LatLng latLng, String countryId) async {
    print("getDiscover");
    final response = await _helper.get(
        "filters/$id?longitude=${latLng.longitude}&latitude=${latLng.latitude}&countryId=$countryId");
    DiscoverItem? discoverItem;
    try {
      discoverItem = DiscoverItem.fromJson(response);
    } catch (e) {
      print(e.toString());
    }
    return discoverItem!;
  }
}
