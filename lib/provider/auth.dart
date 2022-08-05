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
import 'package:new_turki/utilities/convert_numbers.dart';
import 'package:new_turki/utilities/show_dialog.dart';
import 'package:new_turki/widgets/dialog/indicator_dialog.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'favourite_provider.dart';
import 'home_provider.dart';

class Auth with ChangeNotifier {
  TextEditingController keyController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  //used in send otp (login)
  int _start = 30;
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
  String get userPhone =>
      ConvertNumbers.getPhone(keyController.text, phoneController.text);
  bool get isLoading => _isLoading;

  set setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  //used to restrict resend otp
  void startTimer() {
    _start = 30;
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
    _start = 30;
    notifyListeners();
  }

  void setGender(int value, BuildContext context) {
    _gender = value;
    genderController.text = value == 0
        ? AppLocalizations.of(context)!.tr('maleString')
        : value == 1
            ? AppLocalizations.of(context)!.tr('femaleString')
            : "";
    notifyListeners();
  }

  // send otp to user
  Future<void> sendOTP(BuildContext context) async {
    _dialogContext = context;
    _showDialogIndicator(context);
    try {
      _userPhone =
          ConvertNumbers.getPhone(keyController.text, phoneController.text);
      var response =
          await RegistrationRepository().sendOTP({"mobile": _userPhone});
      if (response.statusCode == 200) {
        _userType = UserType.fromJson(json.decode(response.body.toString()));
        _isNewUser = _userType!.code == "C100";
        print("_isNewUser $_isNewUser");
        Navigator.pop(_dialogContext!);
        Navigator.pushNamed(context, "/VerifyPhone");
      } else if (response.statusCode == 401) {
        Navigator.pop(_dialogContext!);
        showSnackBar(
            context, "sorry_you_can_not_log_in_after_deleting_your_account");
      }
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
          "mobile_verification_code":
              ConvertNumbers.convertNumbers(otpController.text.trim())
        });
        print('user$_userPhone');
        if (_response.statusCode == 200) {
          _userData = UserData.fromJson(json.decode(_response.body.toString()));
          _accessToken = _userData!.data!.accessToken;
          await _initPrefs();
          _prefs!.setString("accessToken", _accessToken!);
          initTextController(context);

          _isAuth = true;
          final _favourite =
              Provider.of<FavouriteProvider>(context, listen: false);
          _favourite.getFavouriteData("Bearer " + accessToken);
          final _homeProvider =
              Provider.of<HomeProvider>(context, listen: false);
          final _addressProvider =
              Provider.of<AddressProvider>(context, listen: false);
          if (_homeProvider.locationServiceStatus == 2 ||
              _homeProvider.locationServiceStatus == -1) {
            _homeProvider.setLocationServiceStatus = -1;
            _homeProvider.clearDescription();
            _addressProvider.clearDescription();
            _homeProvider.getHomePageData(true);
          }
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
          initTextController(context);
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
    ShowConfirmDialog().confirmDialog(context, () {
      logOutAction(context);
    }, "Are_you_sure_you_want_to_log_out", "log_out",
        icon: 'assets/images/profile_icons/logout-colored.svg');
  }

  // delete user account
  void deleteAccount(BuildContext context) async {
    await _initPrefs();
    _dialogContext = context;
    ShowConfirmDialog().confirmDialog(context, () async {
      _showDialogIndicator(_dialogContext);
      int statusCode =
          await UserRepository().deleteUserAccount("Bearer $_accessToken");
      print('statusCode $statusCode');
      if (statusCode == 200) {
        Navigator.of(context).pop();
        Navigator.pop(_dialogContext!);
        logOutAction(context);
      } else {
        Navigator.pop(_dialogContext!);
        showSnackBar(context, "unexpected_error");
      }
    }, "are_you_sure_you_want_to_delete_the_account", "delete_account",
        icon: 'assets/images/profile_icons/delete-account.svg');
  }

  void logOutAction(BuildContext context) {
    final _addressProvider =
        Provider.of<AddressProvider>(context, listen: false);
    final _cartProvider = Provider.of<CartProvider>(context, listen: false);
    _cartProvider.cartLength = 0;
    _addressProvider.setSelectedAddress = -1;
    _addressProvider.setUserAddress = UserAddress();
    _isAuth = false;
    _userData = null;
    _gender = -1;
    _accessToken = "";
    _prefs!.remove("accessToken");
    notifyListeners();
    final _homeProvider = Provider.of<HomeProvider>(context, listen: false);
    if (_homeProvider.locationServiceStatus == 2) {
      _homeProvider.setLocationServiceStatus = 0;
      _homeProvider.clearDescription();
      _addressProvider.clearDescription();
    } else {
      _homeProvider.setIsLoading = true;
      _homeProvider.getHomePageData(true,
          latLng: _homeProvider.latLng!,
          countryId: _homeProvider.isoCountryCode);
    }
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
          if (usernameController.text.trim().length > 0)
            "name": usernameController.text,
          if (ageController.text.trim().length > 0)
            "age": ageController.text.trim(),
          if (emailController.text.trim().length > 0 &&
              _userData!.data!.email! != emailController.text.trim())
            "email": emailController.text.trim(),
          if (_gender! > -1) "gender": "$_gender",
        }, "Bearer $_accessToken");

        if (_response.statusCode == 200) {
          _userData = UserData.fromJson(json.decode(_response.body.toString()));
          _userData!.data!.accessToken = _accessToken;
          initTextController(context);
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
                  ? "email_is_used_please_enter_different_email"
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

  // update user data
  Future<void> addUserName(BuildContext context) async {
    _dialogContext = context;
    if (usernameController.text.length > 0) {
      _showDialogIndicator(_dialogContext);
      try {
        _response = await UserRepository().updateInfo({
          if (usernameController.text.trim().length > 0)
            "name": usernameController.text,
        }, "Bearer $_accessToken");
        if (_response.statusCode == 200) {
          _userData = UserData.fromJson(json.decode(_response.body.toString()));
          _userData!.data!.accessToken = _accessToken;
          initTextController(context);
          Navigator.pop(_dialogContext!);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => App(index: 4)),
              ModalRoute.withName('/'));
        } else {
          Navigator.pop(_dialogContext!);
          showSnackBar(context, "please_enter_your_name");
        }
      } catch (e) {
        print('catch add username');
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

  void initCountyCode(value) {
    keyController.text = value;
  }

  void initTextController(BuildContext context) {
    print(userData!.data!.name);
    ageController.text = (_userData!.data!.age!);
    usernameController.text = _userData!.data!.name ?? "";
    try {
      genderController.text =
          AppLocalizations.of(context)!.tr(getGenderString());
    } catch (e) {
      genderController.text = "";
    }
    emailController.text = _userData!.data!.email ?? "";
  }

  String getGenderString() {
    String gender = "";
    gender = (_userData?.data?.gender ?? "") == "0"
        ? 'maleString'
        : (_userData?.data?.gender ?? "") == "1"
            ? 'femaleString'
            : "";
    return gender;
  }

  // test
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

  // test
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

  //  test
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

  //  test
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
