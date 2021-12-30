import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_dropdown_alert/alert_controller.dart';
import 'package:flutter_dropdown_alert/model/data_alert.dart';
import 'package:new_turki/models/user.dart';
import 'package:new_turki/models/user_data.dart';
import 'package:new_turki/repository/registration_repository.dart';
import 'package:new_turki/repository/user_repository.dart';
import 'package:new_turki/screens/app/app.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/convert_phone.dart';
import 'package:new_turki/utilities/show_dialog.dart';
import 'package:new_turki/widgets/dialog/indicator_dialog.dart';

class Auth with ChangeNotifier {
  TextEditingController keyController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  int _start = 59;
  BuildContext? _dialogContext;
  String? _userPhone;
  bool? _isNewUser = false;
  UserData? _userData;
  var _response;
  bool get isAuth => _isAuth!;
  bool? _isAuth = false;
  UserData get userData => _userData!;
  String? _accessToken;

  Timer? _timer;

  Timer get timer => _timer!;

  int get start => _start;

  String get accessToken => _accessToken!; //used to restrict resend otp
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

  String get userPhone => _userPhone ?? "";

  // send otp to user
  Future<void> sendOTP(BuildContext context, {bool navigate = true}) async {
    _dialogContext = context;
    _showDialogIndicator(context);
    try {
      _userPhone =
          ConvertPhone.getPhone(keyController.text, phoneController.text);
      int statusCode =
          await RegistrationRepository().sendOTP({"mobile": _userPhone});
      Navigator.pop(_dialogContext!);

      if (statusCode == 200 && navigate)
        Navigator.pushNamed(context, "/VerifyPhone");
      else {
        AlertController.show(
            AppLocalizations.of(context)!.tr('error'),
            AppLocalizations.of(context)!.tr('unexpected_error'),
            TypeAlert.error);
      }
    } catch (e) {
      print(e.toString());
      Navigator.pop(_dialogContext!);
    }
  }

  // verify otp and login
  Future<void> verifyOTP(BuildContext context) async {
    print(otpController.text.length.toString() + "l");
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
          ageController.text = (_userData!.data!.age!);
          usernameController.text = _userData!.data!.name ?? "";
          genderController.text = _userData!.data!.gender ?? "";
          emailController.text = _userData!.data!.email ?? "";
          _isAuth = true;
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
  void logOut(BuildContext context) {
    ShowConfirmDialog()
        .confirmDialog(context, "Are_you_sure_you_want_to_log_out", () {
      _userData = null;
      _isAuth = false;
      notifyListeners();
    });
  }

  // add new address
  Future<void> addNewAddress(
      BuildContext context, double lat, double lng, String address) async {
    _dialogContext = context;

    _showDialogIndicator(_dialogContext);
    try {
      _response = await UserRepository().addAddress({
        "country_id": "1",
        "city_id": "2",
        "address": "$address address ",
        "comment": "$address address ",
        "label": "label",
        "is_default": "0",
        "long": "$lng",
        "lat": "$lat",
      }, "Bearer $_accessToken");
      print(_response.body.toString());

      if (_response.statusCode == 200) {
        // showSnackBar(context, 'data_has_been_updated_successfully');
        // AlertController.show(
        //     " ",
        //     AppLocalizations.of(context)!
        //         .tr('data_has_been_updated_successfully'),
        //     TypeAlert.success);

        Navigator.pop(_dialogContext!);
        Navigator.pop(context);
      } else {
        Navigator.pop(_dialogContext!);
        showSnackBar(context, "unexpected_error");

        // AlertController.show(
        //     "",
        //     AppLocalizations.of(context)!.tr(_response.statusCode == 400
        //         ? "please_enter_your_name"
        //         : "unexpected_error"),
        //     TypeAlert.error);
      }
    } catch (e) {
      print('catch');
      print(e.toString());
      if (Navigator.canPop(_dialogContext!)) Navigator.pop(_dialogContext!);
      showSnackBar(context, "unexpected_error");
      // AlertController.show(
      //     "",
      //     AppLocalizations.of(context)!.tr("unexpected_error"),
      //     TypeAlert.error);
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
          if (usernameController.text.length > 0)
            "name": usernameController.text,
          if (ageController.text.length > 0) "age": ageController.text.trim(),
          if (emailController.text.length > 0)
            "email": emailController.text.trim(),
        }, "Bearer $_accessToken");
        if (_response.statusCode == 200) {
          print(_response.body.toString());
          _userData = UserData.fromJson(json.decode(_response.body.toString()));
          _userData!.data!.accessToken = _accessToken;
          ageController.text = _userData!.data!.age ?? " ";
          usernameController.text = _userData!.data!.name ?? " ";
          genderController.text = _userData!.data!.gender ?? " ";
          emailController.text = _userData!.data!.email ?? " ";
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
        print('catch');
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

  //for test
  TextEditingController giftController = TextEditingController();
  String _deliveryAddress = "الرياض الياسيمن ";
  bool _isLoading = true;
  int _cardValue = 0;
  int get cardValue => _cardValue;
  GlobalKey<FormState>? formKey;

  String get deliveryAddress => _deliveryAddress;

  set setDeliveryAddress(String value) {
    _deliveryAddress = value;
  }

  User _user = User(
      name: 'رامي الأمير',
      phone: '0580809976',
      lng: 1.0,
      lat: 1.0,
      orders: 6,
      credit: 100.6,
      category: 'الفئة الفضية',
      point: 6500);

  bool get isLoading => _isLoading;

  User get user => _user;

  Future<void> login(BuildContext context) async {
    _showDialogIndicator(context);

    _isAuth = false;

    await Future.delayed(Duration(milliseconds: 2500), () {
      notifyListeners();
    });
    _user = User(
        name: 'رامي الأمير',
        phone: '0580809976',
        lng: 1.0,
        lat: 1.0,
        orders: 6,
        credit: 100.6,
        category: 'الفئة الفضية',
        point: 6500);

    Navigator.pop(context);
    notifyListeners();
  }

  Future<void> getUserData(String token) async {
    await Future.delayed(Duration(milliseconds: 1500), () {
      _isAuth = false;
      _isLoading = false;
    });
    // if (isAuth)
    //   await login3();
    // else
    //   _isAuthStatus = 0;
    notifyListeners();
  }

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

  void initCountyCode() {
    keyController.text = '+966';
  }
}
