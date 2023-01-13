import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/banners_data.dart';
import '../models/category_data.dart';
import '../models/discover_data.dart';
import '../models/discover_item.dart';
import '../core/service/networking/api_base_helper.dart';
import '../core/service/service_locator.dart';

class HomeRepository {
  final ApiBaseHelper _helper = sl<ApiBaseHelper>();

  Future<CategoryData> getCategoriesList(
      LatLng latLng, String countryId) async {
    final response = await _helper.get(
        "categories/categories-app?longitude=${latLng.longitude}&latitude=${latLng.latitude}&countryId=$countryId");
    CategoryData? categoryData;
    try {
      categoryData = CategoryData.fromJson(response);
    } catch (_) {}
    return categoryData!;
  }

  Future<BannersData> getBannersList(
      int categoryId, LatLng latLng, String countryId) async {
    final response = await _helper.get(
        "banners/by-category/$categoryId?longitude=${latLng.longitude}&latitude=${latLng.latitude}&countryId=$countryId");
    BannersData? bannersData;
    try {
      bannersData = BannersData.fromJson(response);
    } catch (_) {}
    return bannersData!;
  }

  Future<DiscoverData> getDiscover(
      int categoryId, LatLng latLng, String countryId) async {
    final response = await _helper.get(
        "filters/by-category/$categoryId?active=1&longitude=${latLng.longitude}&latitude=${latLng.latitude}&countryId=$countryId");
    DiscoverData? discoverItem;
    try {
      discoverItem = DiscoverData.fromJson(response);
    } catch (_) {}
    return discoverItem!;
  }

  Future<DiscoverItem> getDiscoverItem(
      int id, LatLng latLng, String countryId) async {
    final response = await _helper.get(
        "filters/$id?longitude=${latLng.longitude}&latitude=${latLng.latitude}&countryId=$countryId");
    DiscoverItem? discoverItem;
    try {
      discoverItem = DiscoverItem.fromJson(response);
    } catch (_) {}
    return discoverItem!;
  }
}
