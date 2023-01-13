import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import '../core/constants/fixed_assets.dart';
import '../core/constants/route_constants.dart';
import '../core/service/service_locator.dart';
import '../models/user_data.dart';
import '../models/user_type.dart';
import '../repository/registration_repository.dart';
import '../repository/user_repository.dart';
import '../presentation/screens/app/app.dart';
import '../core/service/firebase_helper.dart';
import '../core/utilities/convert_numbers.dart';
import '../core/utilities/show_dialog.dart';
import '../core/utilities/show_snack_bar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../presentation/widgets/dialog/indicator_dialog.dart';
import 'location_provider.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  TextEditingController keyController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

  //used in send otp (login)
  int _start = 30;
  //used to hide dialog indicator
  BuildContext? _dialogContext;
  String? _userPhone;
  bool? _isNewUser = false;

  //new or old user
  UserType? _userType;
  UserData? _userData;
  late http.Response _response;
  bool? _isAuth = false;
  String? _accessToken;
  SharedPreferences? _prefs;
  bool _isLoading = true;
  bool _retry = false;
  Timer? _timer;
  GlobalKey<FormState>? formKey;
  String? _isoCountryCode;
  bool _logoVisibility = true;

  String? get isoCountryCode => _isoCountryCode;

  bool get logoVisibility => _logoVisibility;
  UserData? get userData => _userData;
  Timer get timer => _timer!;
  bool get isAuth => _isAuth!;
  bool get retry => _retry;
  int get start => _start;
  String get accessToken => _accessToken ?? "";
  String get userPhone =>
      ConvertNumbers.getPhone(keyController.text, phoneController.text);
  bool get isLoading => _isLoading;
  bool get isNewUser => _isNewUser ?? false;

  set setIsoCountryCode(String value) {
    _isoCountryCode = value;
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

  // send otp to user
  Future<void> sendOTP(BuildContext context, {bool navigate = true}) async {
    _dialogContext = context;
    _showDialogIndicator(context);
    try {
      _userPhone =
          ConvertNumbers.getPhone(keyController.text, phoneController.text);
      var response =
          await sl<RegistrationRepository>().sendOTP({"mobile": _userPhone});
      if (response.statusCode == 200) {
        _userType = UserType.fromJson(json.decode(response.body.toString()));
        _isNewUser = _userType!.code == "C100";
        Navigator.pop(_dialogContext!);
        // ignore: use_build_context_synchronously
        if (navigate) Navigator.pushNamed(context, verifyPhone);
      } else if (response.statusCode == 401) {
        Navigator.pop(_dialogContext!);
        // ignore: use_build_context_synchronously
        sl<ShowSnackBar>().show(
            context, "sorry_you_can_not_log_in_after_deleting_your_account");
      }
    } catch (_) {
      sl<ShowSnackBar>().show(context, "unexpected_error");
      Navigator.pop(_dialogContext!);
    }
  }

  // init Shared Preferences
  Future<void> _initPrefs() async {
    _prefs = _prefs ?? await SharedPreferences.getInstance();
  }

  // verify otp and login
  Future<void> verifyOTP(BuildContext context) async {
    _dialogContext = context;
    if (otpController.text.length < 4) {
      sl<ShowSnackBar>().show(context, 'please_enter_otp');
    } else {
      _logoVisibility = true;
      _showDialogIndicator(_dialogContext);
      try {
        _response = await sl<RegistrationRepository>().verifyOtpCode({
          "mobile": _userPhone,
          "mobile_verification_code":
              ConvertNumbers.convertNumbers(otpController.text.trim())
        });
        if (_response.statusCode == 200) {
          _userData = UserData.fromJson(json.decode(_response.body.toString()));
          _accessToken = _userData!.data!.accessToken;
          FirebaseHelper().pushAnalyticsEvent(name: "login");
          await _initPrefs();
          _prefs!.setString("accessToken", _accessToken!);
          _isAuth = true;
          Navigator.pop(_dialogContext!);
          _isNewUser!
              // ignore: use_build_context_synchronously
              ? Navigator.of(context).pushNamedAndRemoveUntil(
                  username, (Route<dynamic> route) => false)
              // ignore: use_build_context_synchronously
              : Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => const App(index: 4)),
                  ModalRoute.withName('/'));
        } else {
          Navigator.pop(_dialogContext!);
          // ignore: use_build_context_synchronously
          sl<ShowSnackBar>().show(
              context,
              _response.statusCode != 400
                  ? "unexpected_error"
                  : 'invalid_activation_code');
        }
      } catch (_) {
        if (Navigator.canPop(_dialogContext!)) Navigator.pop(_dialogContext!);
        sl<ShowSnackBar>().show(
            context,
            _response.statusCode == 400
                ? "unexpected_error"
                : 'invalid_activation_code');
      }
    }
  }

  // auto login
  Future<void> getUserData(BuildContext context, String token) async {
    _isLoading = true;
    if (token.isNotEmpty) {
      http.Response response;
      try {
        response = await sl<RegistrationRepository>().login("Bearer $token");
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
    notifyListeners();
  }

  // delete user account
  void deleteAccount(BuildContext context) async {
    await _initPrefs();
    _dialogContext = context;
    // ignore: use_build_context_synchronously
    ShowConfirmDialog().confirmDialog(context, () async {
      _showDialogIndicator(_dialogContext);
      int statusCode =
          await UserRepository().deleteUserAccount("Bearer $_accessToken");
      if (statusCode == 200) {
        // ignore: use_build_context_synchronously
        Navigator.of(context).pop();
        Navigator.pop(_dialogContext!);
        // ignore: use_build_context_synchronously
        logOutAction(context);
      } else {
        Navigator.pop(_dialogContext!);
        // ignore: use_build_context_synchronously
        sl<ShowSnackBar>().show(context, "unexpected_error");
      }
    }, "are_you_sure_you_want_to_delete_the_account", "delete_account",
        icon: FixedAssets.deleteAccount);
  }

  // logout
  void logOut(BuildContext context) async {
    await _initPrefs();
    // ignore: use_build_context_synchronously
    ShowConfirmDialog().confirmDialog(context, () {
      logOutAction(context);
    }, "Are_you_sure_you_want_to_log_out", "log_out", icon: FixedAssets.logout);
  }

  // logout action
  void logOutAction(BuildContext context) async {
    _userData = null;
    _isAuth = false;
    _accessToken = "";
    _prefs!.remove("accessToken");
    final locationProvider =
        Provider.of<LocationProvider>(context, listen: false);
    locationProvider.initDataAfterLogout();
    notifyListeners();
  }

  Future<void> addUsername(BuildContext context) async {
    _dialogContext = context;
    if (usernameController.text.isNotEmpty) {
      _showDialogIndicator(_dialogContext);
      try {
        var response = await UserRepository().updateInfo({
          if (usernameController.text.trim().isNotEmpty)
            "name": usernameController.text,
        }, "Bearer $_accessToken");
        if (response.statusCode == 200) {
          FirebaseHelper().pushAnalyticsEvent(name: "sign_up");
          _userData = UserData.fromJson(json.decode(response.body.toString()));
          _userData!.data!.name = usernameController.text;
          Navigator.pop(_dialogContext!);
          // ignore: use_build_context_synchronously
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => const App(index: 4)),
              ModalRoute.withName('/'));
        } else {
          Navigator.pop(_dialogContext!);
          // ignore: use_build_context_synchronously
          sl<ShowSnackBar>().show(context, "unexpected_error");
        }
        notifyListeners();
      } catch (_) {
        if (Navigator.canPop(_dialogContext!)) Navigator.pop(_dialogContext!);
        sl<ShowSnackBar>().show(context, "unexpected_error");
      }
    } else {
      sl<ShowSnackBar>().show(context, "please_enter_your_name");
    }
  }

  // show indicator dialog٣
  void _showDialogIndicator(context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          _dialogContext = context;
          return const IndicatorDialog();
        });
  }

  void initCountyCode(value) {
    keyController.text = value;
  }
}
