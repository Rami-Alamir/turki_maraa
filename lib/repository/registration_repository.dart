import 'package:new_turki/models/user_type.dart';
import 'package:new_turki/networking/api_base_helper.dart';

class RegistrationRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  //send otp
  Future<UserType> sendOTP(body) async {
    UserType? _userType;
    print('send otp');
    final response = await _helper.post("sendOtpCode", body);
    try {
      _userType = UserType.fromJson(response);
    } catch (e) {
      print(e.toString());
    }
    return _userType!;
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
