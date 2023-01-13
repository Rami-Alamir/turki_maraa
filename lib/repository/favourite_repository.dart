import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/favourite.dart';
import '../core/service/networking/api_base_helper.dart';

class FavouriteRepository {
  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<Favourite> getFavouriteList(
      String authorization, LatLng latLng, String countryId) async {
    final response = await _helper.get(
        "wishlists?page=1&per_page=50&longitude=${latLng.longitude}&latitude=${latLng.latitude}&countryId=$countryId",
        authorization: authorization);
    Favourite? favourite;
    try {
      favourite = Favourite.fromJson(response);
    } catch (_) {}
    return favourite!;
  }

  Future<int> deleteFromFavourite(String id, String authorization) async {
    final response = await _helper.delete("wishlists/remove-from-wishlist/$id",
        authorization: authorization);
    return response;
  }

  Future<int> addFavourite(id, String authorization) async {
    final response = await _helper.get3("wishlists/add-to-wishlist/$id",
        authorization: authorization);
    return response;
  }
}
