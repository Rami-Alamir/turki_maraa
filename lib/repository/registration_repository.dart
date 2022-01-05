import 'package:new_turki/networking/api_base_helper.dart';

class RegistrationRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  //send otp
  Future<int> sendOTP(body) async {
    final responseStatusCode = await _helper.post2("sendOtpCode", body);
    return responseStatusCode;
  }

  //verify Otp Code
  Future<dynamic> verifyOtpCode(body) async {
    final response = await _helper.post3("verfiyOtpCode", body);
    return response;
  }

  //get user data
  Future<dynamic> login(String authorization) async {
    print("login");
    final response = await _helper.get2("customers/show-profile",
        authorization: authorization);
    return response;
  }
}
