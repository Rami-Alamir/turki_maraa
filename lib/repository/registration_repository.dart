import 'package:new_turki/networking/api_base_helper.dart';

class RegistrationRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  //send otp
  Future<dynamic> sendOTP(body) async {
    print('sendOtpCode');
    final response = await _helper.post3("sendOtpCode", body);
    print(response.toString());
    return response!;
  }

  //verify Otp Code
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
