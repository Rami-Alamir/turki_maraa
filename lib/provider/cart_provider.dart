import 'package:flutter/material.dart';
import 'package:new_turki/dummy_data/dummy_data.dart';
import 'package:new_turki/models/cart.dart';
import 'package:new_turki/utilities/show_dialog.dart';
import 'package:new_turki/widgets/dialog/indicator_dialog.dart';

class CartProvider with ChangeNotifier {
  TextEditingController noteController = TextEditingController();
  bool _isLoading = true;
  bool _retry = false;
  bool _useCredit = false;
  Cart? _cartData;
  int _selectedPayment = 0;
  int _selectedDate = 0;
  int _selectedTime = 0;
  int _isAuthStatus = 0;
  int _cartLength = 0;

  int get cartLength => _cartLength;

  int get isAuthStatus => _isAuthStatus;

  bool get isAuth => _isAuth = false;
  bool? _isAuth = false;

  CartProvider(_isAuthStatus) {
    if (_isAuthStatus == 1) {
      _isAuth = true;
      _isLoading = true;

      getCartData();
    } else if (_isAuthStatus == 0) {
      _isAuth = false;
      _isLoading = false;
      notifyListeners();
    }
  }
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

  bool get isLoading => _isLoading;
  bool get retry => _retry;
  Cart get cartData => _cartData!;

  Future<void> getCartData() async {
    await Future.delayed(Duration(milliseconds: 500), () {
      _cartData = DummyData.cart;
      _isLoading = false;
      _cartLength = _cartData?.items.length ?? 0;
      notifyListeners();
    });
  }

  Future<void> removeCartItemData(context, index) async {
    _dialogContext = context;
    _showDialogIndicator(context);
    await Future.delayed(Duration(milliseconds: 500), () {
      _cartData!.items.removeAt(index);
    });
    Navigator.pop(_dialogContext!);
    notifyListeners();
  }

  Future<void> reInitOrdersList() async {
    await Future.delayed(Duration(milliseconds: 500), () {
      _cartData = DummyData.cart;
      _isLoading = false;
      notifyListeners();
    });
  }

  BuildContext? _dialogContext;

  Future<void> removeItem(BuildContext context, int index) async {
    if (_cartData!.items[index].qty == "1") {
      ShowConfirmDialog().confirmDialog(
          context, "are_you_sure_you_want_to_remove_the_product", () {
        removeCartItemData(context, index);
      });
    } else {
      _cartData!.items[index].qty =
          (int.parse(_cartData!.items[index].qty) - 1).toString();
      notifyListeners();
      _showDialogIndicator(context);

      await getCartData();
      Navigator.pop(_dialogContext!);
    }
  }

  Future<void> addItem(BuildContext context, int index) async {
    _cartData!.items[index].qty =
        (int.parse(_cartData!.items[index].qty) + 1).toString();
    notifyListeners();
    _showDialogIndicator(context);
    await getCartData();
    Navigator.pop(_dialogContext!);
  }

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
