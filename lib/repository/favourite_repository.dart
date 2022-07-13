import 'package:new_turki/models/favourite.dart';
import 'package:new_turki/networking/api_base_helper.dart';

class FavouriteRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  //get Favourite list
  Future<Favourite> getFavouriteList(String authorization) async {
    final response = await _helper.get("wishlists?page=1&per_page=100",
        authorization: authorization);
    Favourite? favourite;
    try {
      favourite = Favourite.fromJson(response);
    } catch (e) {
      print(e.toString());
    }
    return favourite!;
  }

  //delete From Favourite
  Future<int> deleteFromFavourite(String id, String authorization) async {
    print("wishlists/remove-from-wishlist/$id");
    final response = await _helper.delete("wishlists/remove-from-wishlist/$id",
        authorization: authorization);
    return response;
  }

  //add to Favourite
  Future<int> addFavourite(id, String authorization) async {
    final response = await _helper.get3("wishlists/add-to-wishlist/$id",
        authorization: authorization);
    return response;
  }
}
