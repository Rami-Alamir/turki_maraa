import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../core/service/service_locator.dart';
import '../core/utilities/dialog_helper.dart';
import '../models/user_data.dart';
import '../models/user_type.dart';
import '../repository/login_repository.dart';
import '../repository/user_repository.dart';
import '../core/service/firebase_helper.dart';
import '../core/utilities/convert_numbers.dart';

class Auth with ChangeNotifier {
  FlutterSecureStorage? _localStorage;
  //used in send otp (login)
  int _start = 30;
  String? _userPhone;
  String _phoneControllerValue = "";
  String _otpControllerValue = "";
  String _usernameControllerValue = "";
  bool? _isNewUser = false;
  //new or old user
  UserType? _userType;
  UserData? _userData;
  bool? _isAuth = false;
  String? _accessToken;
  bool _isLoading = true;
  bool _retry = false;
  Timer? _timer;
  String? _isoCountryCode;
  bool _logoVisibility = true;
  String _dialCode = "+966";

  String? get isoCountryCode => _isoCountryCode;
  String get dialCode => _dialCode;
  bool get logoVisibility => _logoVisibility;
  UserData? get userData => _userData;
  Timer get timer => _timer!;
  bool get isAuth => _isAuth!;
  bool get retry => _retry;
  int get start => _start;
  String get accessToken => _accessToken ?? "";
  String get userPhone =>
      ConvertNumbers.getPhone(_dialCode, _phoneControllerValue);
  bool get isLoading => _isLoading;
  bool get isNewUser => _isNewUser ?? false;

  set isNewUser(bool value) {
    _isNewUser = value;
  }

  set usernameControllerValue(String value) {
    _usernameControllerValue = value;
  }

  set userPhoneControllerValue(String value) {
    _phoneControllerValue = value;
  }

  set otpControllerValue(String value) {
    _otpControllerValue = value;
  }

  set setIsoCountryCode(String value) {
    _isoCountryCode = value;
  }

  set setDialCode(String value) {
    _dialCode = value;
  }

  set setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  set logoVisibility(bool value) {
    _logoVisibility = value;
    notifyListeners();
  }

  //used to restrict resend otp
  void startTimer() {
    _start = 30;
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          timer.cancel();
        } else {
          _start--;
        }
        notifyListeners();
      },
    );
    _start = 30;
    notifyListeners();
  }

  Future<int> sendOTP(BuildContext context, {bool navigate = true}) async {
    sl<DialogHelper>().showIndicatorDialog(context);
    try {
      _userPhone = ConvertNumbers.getPhone(_dialCode, _phoneControllerValue);
      var response =
          await sl<LoginRepository>().sendOTP({"mobile": _userPhone});
      if (response.statusCode == 200) {
        _userType = UserType.fromJson(json.decode(response.body.toString()));
        _isNewUser = _userType!.code == "C100";
      } else {
        _start = 0;
      }
      return response.statusCode;
    } catch (_) {
      _start = 0;
      return 0;
    }
  }

  // verify otp and login
  Future<int> verifyOTP(BuildContext context) async {
    if (_otpControllerValue.length < 4) {
      return 1;
    } else {
      sl<DialogHelper>().showIndicatorDialog(context);
      try {
        var response = await sl<LoginRepository>().verifyOtpCode({
          "mobile": _userPhone,
          "mobile_verification_code":
              ConvertNumbers.convertNumbers(_otpControllerValue)
        });
        if (response.statusCode == 200) {
          _userData = UserData.fromJson(json.decode(response.body.toString()));
          _accessToken = _userData!.data!.accessToken;
          FirebaseHelper().pushAnalyticsEvent(name: "login");
          _initLocalStorage();
          await _localStorage!.write(key: "accessToken", value: _accessToken!);
          _isAuth = true;
          notifyListeners();
        }
        return response.statusCode;
      } catch (_) {
        return 0;
      }
    }
  }

  Future<void> getUserData(BuildContext context, String token) async {
    _isLoading = true;
    if (token.isNotEmpty) {
      http.Response response;
      try {
        response = await sl<LoginRepository>().login("Bearer $token");
        if (response.statusCode == 200) {
          _userData = UserData.fromJson(json.decode(response.body.toString()));
          _userData!.data!.accessToken = token;
          _accessToken = token;
          _isAuth = true;
        }
      } catch (_) {
        _retry = true;
      }
    }
    _isLoading = false;
    if (_isAuth ?? false) {
      notifyListeners();
    }
  }

  Future<bool> deleteAccount() async {
    try {
      int statusCode =
          await sl<UserRepository>().deleteUserAccount("Bearer $_accessToken");
      if (statusCode == 200) {
        return true;
      }
    } catch (_) {}
    FirebaseHelper().pushAnalyticsEvent(name: 'delete_account');
    return false;
  }

  Future<void> logOut(BuildContext context) async {
    _userData = null;
    _isAuth = false;
    _accessToken = "";
    _initLocalStorage();
    await _localStorage!.delete(key: "accessToken");
    notifyListeners();
  }

  Future<int> addUsername(BuildContext context) async {
    if (_usernameControllerValue.isNotEmpty) {
      sl<DialogHelper>().showIndicatorDialog(context);
      try {
        var response = await sl<UserRepository>().updateInfo({
          "name": _usernameControllerValue,
        }, "Bearer $_accessToken");
        if (response.statusCode == 200) {
          FirebaseHelper().pushAnalyticsEvent(name: "sign_up");
          _userData = UserData.fromJson(json.decode(response.body.toString()));
          _userData!.data!.name = _usernameControllerValue;
          _userData!.data!.accessToken = _accessToken;
          notifyListeners();
        }
        return response.statusCode;
      } catch (_) {
        return 0;
      }
    } else {
      return 1;
    }
  }

  // init local storage
  void _initLocalStorage() {
    _localStorage = _localStorage ?? const FlutterSecureStorage();
  }

  void updateCountry(String dialCode, String isoCountryCode) {
    _isoCountryCode = isoCountryCode;
    _dialCode = dialCode;
    notifyListeners();
  }
}
