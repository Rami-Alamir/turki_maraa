import '../models/user_address.dart';
import '../core/service/networking/api_base_helper.dart';
import '../core/service/service_locator.dart';

class UserRepository {
  final ApiBaseHelper _helper = sl<ApiBaseHelper>();

  Future<dynamic> updateInfo(body, String authorization) async {
    final response = await _helper.post3("customers/edit-profile", body,
        authorization: authorization);
    return response;
  }

  Future<int> deleteUserAccount(String authorization) async {
    final statusCode = await _helper.delete("customers/delete-customer",
        authorization: authorization);
    return statusCode;
  }

  Future<dynamic> addAddress(body, String authorization) async {
    final response = await _helper.post3("customers/add-address", body,
        authorization: authorization);
    return response;
  }

  Future<dynamic> updateAddress(body, String authorization, String id) async {
    final response = await _helper.post3("customers/edit-address/$id", body,
        authorization: authorization);
    return response;
  }

  Future<dynamic> deleteAddress(String authorization, String id) async {
    final response = await _helper.post3("customers/delete-address/$id", {},
        authorization: authorization);
    return response;
  }

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
