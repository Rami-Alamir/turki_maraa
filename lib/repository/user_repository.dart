import 'package:new_turki/networking/api_base_helper.dart';

class UserRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  //update user personal Info
  Future<dynamic> updateInfo(body, String authorization) async {
    final response = await _helper.post3("customers/edit-profile", body,
        authorization: authorization);
    return response;
  }

  //update add Address Info
  Future<dynamic> addAddress(body, String authorization) async {
    final response = await _helper.post3("customers/add-address", body,
        authorization: authorization);
    return response;
  }
}
