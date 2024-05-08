import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/search_data.dart';
import '../core/service/networking/api_base_helper.dart';
import '../core/service/service_locator.dart';

class SearchRepository {
  final ApiBaseHelper _helper = sl<ApiBaseHelper>();

  Future<List<SearchData>> getSearchResultList(
      String key, LatLng latLng, String countryId) async {
    final response = await _helper.get(
        "products/search/$key?longitude=${latLng.longitude}&latitude=${latLng.latitude}&countryId=$countryId");
    return (response as List).map((p) => SearchData.fromJson(p)).toList();
  }
}
