import '../core/service/networking/api_base_helper.dart';
import '../core/service/service_locator.dart';

class RegistrationRepository {
  final ApiBaseHelper _helper = sl<ApiBaseHelper>();

  Future<dynamic> sendOTP(body) async {
    final response = await _helper.post3("sendOtpCode", body);
    return response!;
  }

  Future<dynamic> verifyOtpCode(body) async {
    final response = await _helper.post3("verfiyOtpCode", body);
    return response;
  }

  //get user data
  Future<dynamic> login(String authorization) async {
    final response = await _helper.get2("customers/show-profile",
        authorization: authorization);
    return response;
  }
}
