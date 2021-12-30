import 'package:new_turki/models/favourite.dart';
import 'package:new_turki/networking/api_base_helper.dart';

class FavouriteRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  //get Favourite list
  Future<Favourite> getFavouriteList(String authorization) async {
    final response =
        await _helper.get("wishlists", authorization: authorization);
    Favourite? favourite;
    try {
      favourite = Favourite.fromJson(response);
    } catch (e) {
      print(e.toString());
    }
    return favourite!;
  }
}
