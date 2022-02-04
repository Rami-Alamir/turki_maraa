import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_dropdown_alert/alert_controller.dart';
import 'package:flutter_dropdown_alert/model/data_alert.dart';
import 'package:new_turki/models/user.dart';
import 'package:new_turki/models/user_address.dart';
import 'package:new_turki/models/user_data.dart';
import 'package:new_turki/models/user_type.dart';
import 'package:new_turki/provider/address_provider.dart';
import 'package:new_turki/provider/cart_provider.dart';
import 'package:new_turki/repository/registration_repository.dart';
import 'package:new_turki/repository/user_repository.dart';
import 'package:new_turki/screens/app/app.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/convert_phone.dart';
import 'package:new_turki/utilities/show_dialog.dart';
import 'package:new_turki/widgets/dialog/indicator_dialog.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'favourite_provider.dart';

class Auth with ChangeNotifier {
  TextEditingController keyController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  //used in send otp (login)
  int _start = 59;
  //used to hide dialog indicator
  BuildContext? _dialogContext;
  String? _userPhone;
  bool? _isNewUser = false;
  //used to update gender
  int? _gender = -1;
  //new or old user
  UserType? _userType;
  UserData? _userData;
  var _response;
  bool? _isAuth = false;
  String? _accessToken;
  SharedPreferences? _prefs;
  bool _isLoading = true;
  bool _retry = false;
  Timer? _timer;

  UserData? get userData => _userData;
  Timer get timer => _timer!;
  bool get isAuth => _isAuth!;
  bool get retry => _retry;
  int get start => _start;
  String get accessToken => _accessToken!;
  int get gender => _gender!;
  String get userPhone => _userPhone ?? "";
  bool get isLoading => _isLoading;

  set setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  //used to restrict resend otp
  void startTimer() {
    _start = 59;
    const oneSec = const Duration(seconds: 1);
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
    _start = 59;
    notifyListeners();
  }

  void setGender(int value, BuildContext context) {
    _gender = value;
    genderController.text = value == 0
        ? 'maleString'
        : value == 1
            ? 'femaleString'
            : "";
    notifyListeners();
  }

  // send otp to user
  Future<void> sendOTP(BuildContext context) async {
    _dialogContext = context;
    _showDialogIndicator(context);
    try {
      _userPhone =
          ConvertPhone.getPhone(keyController.text, phoneController.text);
      _userType =
          await RegistrationRepository().sendOTP({"mobile": _userPhone});
      _isNewUser = _userType!.code == "C100";
      Navigator.pop(_dialogContext!);
      Navigator.pushNamed(context, "/VerifyPhone");
    } catch (e) {
      print(e.toString());
      showSnackBar(context, "unexpected_error");
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
      showSnackBar(context, 'please_enter_otp');
    } else {
      _showDialogIndicator(_dialogContext);
      try {
        _response = await RegistrationRepository().verifyOtpCode({
          "mobile": _userPhone,
          "mobile_verification_code": otpController.text.trim()
        });
        if (_response.statusCode == 200) {
          _userData = UserData.fromJson(json.decode(_response.body.toString()));
          _accessToken = _userData!.data!.accessToken;
          await _initPrefs();
          _prefs!.setString("accessToken", _accessToken!);
          initTextController();

          _isAuth = true;
          final _favourite =
              Provider.of<FavouriteProvider>(context, listen: false);
          _favourite.getFavouriteData("Bearer " + accessToken);
          Navigator.pop(_dialogContext!);
          _isNewUser!
              ? Navigator.of(context).pushNamedAndRemoveUntil(
                  '/Username', (Route<dynamic> route) => false)
              : Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => App(index: 4)),
                  ModalRoute.withName('/'));
        } else {
          Navigator.pop(_dialogContext!);

          showSnackBar(
              context,
              _response.statusCode != 400
                  ? "unexpected_error"
                  : 'invalid_activation_code');
        }
      } catch (e) {
        print('catch');
        print(e.toString());
        if (Navigator.canPop(_dialogContext!)) Navigator.pop(_dialogContext!);
        showSnackBar(
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
    if (token.length > 0) {
      var _response;
      try {
        _response = await RegistrationRepository().login("Bearer $token");
        if (_response.statusCode == 200) {
          _userData = UserData.fromJson(json.decode(_response.body.toString()));
          _accessToken = token;

          _isAuth = true;
          final _favourite =
              Provider.of<FavouriteProvider>(context, listen: false);
          _favourite.getFavouriteData("Bearer " + accessToken);
          initTextController();
        }
      } catch (e) {
        print('catch login');
        print(e.toString());
        _retry = true;
      }
    }
    _isLoading = false;
    notifyListeners();
  }

  // show indicator dialog
  void _showDialogIndicator(context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          _dialogContext = context;
          return IndicatorDialog();
        });
  }

  void showSnackBar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
      AppLocalizations.of(context)!.tr(msg),
      textAlign: TextAlign.center,
    )));
  }

  // logout
  void logOut(BuildContext context) async {
    await _initPrefs();
    final _addressProvider =
        Provider.of<AddressProvider>(context, listen: false);
    final _cartProvider = Provider.of<CartProvider>(context, listen: false);
    _cartProvider.cartLength = 0;
    _addressProvider.setSelectedAddress = -1;
    _addressProvider.setUserAddress = UserAddress();
    ShowConfirmDialog()
        .confirmDialog(context, "Are_you_sure_you_want_to_log_out", () {
      _userData = null;
      _isAuth = false;
      _gender = -1;
      _accessToken = "";
      _prefs!.remove("accessToken");
      notifyListeners();
    });
  }

  // update user data
  Future<void> updateUser(BuildContext context) async {
    _dialogContext = context;
    if (usernameController.text.length > 0 ||
        ageController.text.length > 0 ||
        emailController.text.length > 0) {
      _showDialogIndicator(_dialogContext);
      try {
        _response = await UserRepository().updateInfo({
          if (usernameController.text.length > 0)
            "name": usernameController.text,
          if (ageController.text.length > 0) "age": ageController.text.trim(),
          if (emailController.text.length > 0)
            "email": emailController.text.trim(),
          if (_gender! > -1) "gender": "$_gender",
        }, "Bearer $_accessToken");
        if (_response.statusCode == 200) {
          print(_response.body.toString());
          _userData = UserData.fromJson(json.decode(_response.body.toString()));
          _userData!.data!.accessToken = _accessToken;
          initTextController();
          showSnackBar(context, 'data_has_been_updated_successfully');
          // AlertController.show(
          //     " ",
          //     AppLocalizations.of(context)!
          //         .tr('data_has_been_updated_successfully'),
          //     TypeAlert.success);

          Navigator.pop(_dialogContext!);
        } else {
          Navigator.pop(_dialogContext!);
          showSnackBar(
              context,
              _response.statusCode == 400
                  ? "please_enter_your_name"
                  : "unexpected_error");

          // AlertController.show(
          //     "",
          //     AppLocalizations.of(context)!.tr(_response.statusCode == 400
          //         ? "please_enter_your_name"
          //         : "unexpected_error"),
          //     TypeAlert.error);
        }
      } catch (e) {
        print('catch update user');
        print(e.toString());
        if (Navigator.canPop(_dialogContext!)) Navigator.pop(_dialogContext!);
        showSnackBar(context, "unexpected_error");
        // AlertController.show(
        //     "",
        //     AppLocalizations.of(context)!.tr("unexpected_error"),
        //     TypeAlert.error);
      }
    }
  }

  void initCountyCode() {
    keyController.text = '+966';
  }

  void initTextController() {
    ageController.text = (_userData!.data!.age!);
    usernameController.text = _userData!.data!.name ?? "";
    genderController.text = getGenderString();
    emailController.text = _userData!.data!.email ?? "";
  }

  String getGenderString() {
    String gender = "";
    print('x${(_userData?.data?.gender ?? "")}x');
    print('x${(_userData?.data?.gender ?? "") == "0"}x');
    gender = (_userData?.data?.gender ?? "") == "0"
        ? 'maleString'
        : (_userData?.data?.gender ?? "") == "1"
            ? 'femaleString'
            : "";
    return gender;
  }

  //for test
  TextEditingController giftController = TextEditingController();
  int _cardValue = 0;
  int get cardValue => _cardValue;
  GlobalKey<FormState>? formKey;
  User _user = User(
      name: 'رامي الأمير',
      phone: '0580809976',
      lng: 1.0,
      lat: 1.0,
      orders: 6,
      credit: 100.6,
      category: 'الفئة الفضية',
      point: 6500);
  User get user => _user;

  //for test
  Future<void> delayed() async {
    await Future.delayed(Duration(milliseconds: 2500), () {
      notifyListeners();
    });
  }

  Future<void> getUserWallet() async {
    await Future.delayed(Duration(milliseconds: 2500), () {
      notifyListeners();
    });
  }

  Future<void> getUserPoints() async {
    await Future.delayed(Duration(milliseconds: 2500), () {
      notifyListeners();
    });
  }

  void redeemPoints(BuildContext context, int point) {
    if (point > user.point!.toInt())
      AlertController.show(
          "",
          AppLocalizations.of(context)!.tr('your_points_balance_is_not_enough'),
          TypeAlert.error);
    else {
      AlertController.show(
          AppLocalizations.of(context)!.tr('successfully'),
          AppLocalizations.of(context)!
              .tr('your_points_have_been_successfully_redeemed'),
          TypeAlert.success);

      _user.point = (_user.point)! - (point * 1.0);
      notifyListeners();
    }
  }

  Future<void> checkGiftCard(BuildContext context) async {
    if (giftController.text.length == 16) {
      _showDialogIndicator(context);
      await Future.delayed(Duration(milliseconds: 2500), () {
        notifyListeners();
      });
      Navigator.pop(_dialogContext!);

      if (Random().nextBool()) {
        giftController.clear();
        Navigator.of(context, rootNavigator: true)
            .pushNamed('/Success', arguments: "successfully");
      } else
        AlertController.show(
            AppLocalizations.of(context)!.tr('error'),
            AppLocalizations.of(context)!.tr('the_card_number_is_incorrect'),
            TypeAlert.error);
    }
  }
}
