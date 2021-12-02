import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_dropdown_alert/alert_controller.dart';
import 'package:flutter_dropdown_alert/model/data_alert.dart';
import 'package:new_turki/models/user.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/show_dialog.dart';
import 'package:new_turki/widgets/dialog/indicator_dialog.dart';

class Auth with ChangeNotifier {
  TextEditingController ageController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController nationalityController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController giftController = TextEditingController();
  String _deliveryAddress = "الرياض الياسيمن ";
  bool _isLoading = true;
  int _cardValue = 0;

  int get cardValue => _cardValue;

  String get deliveryAddress => _deliveryAddress;

  set setDeliveryAddress(String value) {
    _deliveryAddress = value;
  }

  BuildContext? _dialogContext;
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
  bool? _isAuth = false;

  User get user => _user;

  bool get isAuth => _isAuth!;

  Future<void> login() async {
    ageController.text = (_user.age ?? 0) > 0 ? _user.age.toString() : "";
    usernameController.text = _user.name ?? "";
    nationalityController.text = _user.nationality ?? "";
    emailController.text = _user.email ?? "";
  }

  Future<void> getUserData(String token) async {
    await login();
    await Future.delayed(Duration(milliseconds: 5500), () {
      _isAuth = true;
      _isLoading = false;

      notifyListeners();
    });
  }

  Future<void> updateUser(BuildContext context) async {
    _showDialogIndicator(context);
    await Future.delayed(Duration(milliseconds: 2500), () {
      notifyListeners();
    });
    Navigator.pop(_dialogContext!);
    AlertController.show(
        "",
        AppLocalizations.of(context)!.tr('data_has_been_updated_successfully'),
        TypeAlert.success);
  }

  Future<void> getUser() async {
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

  void logOut(BuildContext context) {
    ShowConfirmDialog()
        .confirmDialog(context, "Are_you_sure_you_want_to_log_out", () {
      _user = User();
      _isAuth = false;
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
