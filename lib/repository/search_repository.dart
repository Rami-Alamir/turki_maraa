import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:new_turki/models/search_data.dart';
import 'package:new_turki/networking/api_base_helper.dart';

class SearchRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  //get search result list
  Future<List<SearchData>> getSearchResultList(
      String key, LatLng latLng, String countryId) async {
    final response = await _helper.get(
        "products/search/$key?longitude=${latLng.longitude}&latitude=${latLng.latitude}&countryId=$countryId");
    return (response as List).map((p) => SearchData.fromJson(p)).toList();
  }
}
