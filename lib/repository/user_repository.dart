import '../models/user_address.dart';
import '../core/service/networking/api_base_helper.dart';

class UserRepository {
  final ApiBaseHelper _helper = ApiBaseHelper();

  //update user personal Info
  Future<dynamic> updateInfo(body, String authorization) async {
    final response = await _helper.post3("customers/edit-profile", body,
        authorization: authorization);
    return response;
  }

  //delete user account
  Future<int> deleteUserAccount(String authorization) async {
    final statusCode = await _helper.delete("customers/delete-customer",
        authorization: authorization);
    return statusCode;
  }

  // add Address Info
  Future<dynamic> addAddress(body, String authorization) async {
    final response = await _helper.post3("customers/add-address", body,
        authorization: authorization);
    return response;
  }

  //update  Address Info
  Future<dynamic> updateAddress(body, String authorization, String id) async {
    final response = await _helper.post3("customers/edit-address/$id", body,
        authorization: authorization);
    return response;
  }

  //delete  Address
  Future<dynamic> deleteAddress(String authorization, String id) async {
    final response = await _helper.post3("customers/delete-address/$id", {},
        authorization: authorization);
    return response;
  }

  //get address list
  Future<UserAddress> getAddressList(String authorization) async {
    final response = await _helper.get("customers/get-addresses",
        authorization: authorization);
    UserAddress? userAddress;
    try {
      userAddress = UserAddress.fromJson(response);
    } catch (_) {}
    return userAddress!;
  }
}
