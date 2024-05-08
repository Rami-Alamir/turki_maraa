import '../core/service/networking/api_base_helper.dart';

class RegistrationRepository {
  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<dynamic> sendOTP(body) async {
    final response = await _helper.post3("sendOtpCode", body);
    return response!;
  }

  Future<dynamic> verifyOtpCode(body) async {
    final response = await _helper.post3("verfiyOtpCode", body);
    return response;
  }

  Future<dynamic> login(String authorization) async {
    final response = await _helper.get2("customers/show-profile",
        authorization: authorization);
    return response;
  }
}
