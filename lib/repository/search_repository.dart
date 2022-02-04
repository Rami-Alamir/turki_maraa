import 'package:new_turki/models/search_data.dart';
import 'package:new_turki/networking/api_base_helper.dart';

class SearchRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  //get search result list
  Future<List<SearchData>> getSearchResultList(String key) async {
    final response = await _helper.get("products/search/$key");
    return (response as List).map((p) => SearchData.fromJson(p)).toList();
  }
}
