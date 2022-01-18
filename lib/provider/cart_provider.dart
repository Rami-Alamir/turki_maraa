import 'package:flutter/material.dart';
import 'package:new_turki/models/cart_data.dart';
import 'package:new_turki/repository/cart_repository.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/widgets/dialog/indicator_dialog.dart';

class CartProvider with ChangeNotifier {
  TextEditingController noteController = TextEditingController();
  TextEditingController promoCodeController = TextEditingController();
  bool _isLoading = true;
  bool _retry = false;
  CartData? _cartData;
  bool get isLoading => _isLoading;
  bool get retry => _retry;
  CartData? get cartData => _cartData;

  set setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  //add item to cart
  Future<void> addToCart({
    required BuildContext context,
    required String authorization,
    required String productId,
    required String quantity,
    String preparationId = '',
    String sizeId = '',
    String cutId = '',
    String isShalwata = '',
  }) async {
    var _response;
    _dialogContext = context;
    _showDialogIndicator(context);
    try {
      _response = await CartRepository().addToCart({
        "items": [
          {
            "product_id": "$productId",
            "quantity": "$quantity",
            "preparation_id": "$preparationId",
            "size_id": "$sizeId",
            "cut_id": "$cutId",
            "is_shalwata": "0"
          }
        ],
        "comment": "",
        "using_wallet": 0,
        "payment_type_id": 1,
        "applied_discount_code": "",
        "address_id": 18,
        "address": "test"
      }, authorization);

      showSnackBar(context,
          _response == 200 ? "product_added_cart" : "unexpected_error");
    } catch (e) {
      print('catch');
      print(e.toString());
      showSnackBar(context, "unexpected_error");
    }
    Navigator.pop(_dialogContext!);
  }

  //getCartData
  Future<void> getCartData(String token) async {
    _isLoading = true;
    _retry = false;

    try {
      _cartData = await CartRepository().getCartList("Bearer $token");
    } catch (e) {
      print('catch cart');
      print(e.toString());
      _retry = true;
    }
    _isLoading = false;
    notifyListeners();
  }

  void showSnackBar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
      AppLocalizations.of(context)!.tr(msg),
      textAlign: TextAlign.center,
    )));
  }

  //for test

  bool _useCredit = false;
  int _selectedPayment = 0;
  int _selectedDate = 0;
  int _selectedTime = 0;
  int _cartLength = 0;

  int get cartLength => _cartLength;

  bool get isAuth => _isAuth;
  bool _isAuth = false;

  int get selectedDate => _selectedDate;

  set setSelectedDate(int value) {
    _selectedDate = value;
    notifyListeners();
  }

  int get selectedPayment => _selectedPayment;

  bool get useCredit => _useCredit;

  set usMyCredit(bool value) {
    _useCredit = value;
    notifyListeners();
  }

  set setSelectedPayment(int value) {
    _selectedPayment = value;
    notifyListeners();
  }

  BuildContext? _dialogContext;

  // show indicator dialog
  void _showDialogIndicator(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          _dialogContext = context;
          return IndicatorDialog();
        });
  }

  int get selectedTime => _selectedTime;

  set setSelectedTime(int value) {
    _selectedTime = value;
    notifyListeners();
  }
}
