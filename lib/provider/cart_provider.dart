import 'package:flutter/material.dart';
import 'package:new_turki/models/cart_data.dart';
import 'package:new_turki/repository/cart_repository.dart';
import 'package:new_turki/repository/order_repository.dart';
import 'package:new_turki/screens/orders/order_success.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/widgets/dialog/indicator_dialog.dart';

class CartProvider with ChangeNotifier {
  TextEditingController noteController = TextEditingController();
  TextEditingController promoCodeController = TextEditingController();
  bool _isLoading = true;
  bool _retry = false;
  bool _errorMsg = false;
  CartData? _cartData;
  bool _promoIsActive = false;
  String? _authorization;
  bool _useCredit = false;
  int _selectedPayment = -1;
  int _selectedDate = -1;
  int _selectedTime = -1;
  int _cartLength = 0;
  bool _isAuth = false;
  BuildContext? _dialogContext;

  int get cartLength => _cartLength;
  bool get isAuth => _isAuth;
  int get selectedDate => _selectedDate;
  bool get isLoading => _isLoading;
  bool get retry => _retry;
  CartData? get cartData => _cartData;
  int get selectedPayment => _selectedPayment;
  int get selectedTime => _selectedTime;
  bool get useCredit => _useCredit;
  bool get errorMsg => _errorMsg;
  bool get promoIsActive => _promoIsActive;

  set cartLength(int value) {
    _cartLength = value;
    notifyListeners();
  }

  set setSelectedDate(int value) {
    _selectedDate = value;
    notifyListeners();
  }

  set usMyCredit(bool value) {
    _useCredit = value;
    notifyListeners();
  }

  set setSelectedPayment(int value) {
    _selectedPayment = value;
    notifyListeners();
  }

  set setSelectedTime(int value) {
    _selectedTime = value;
    notifyListeners();
  }

  set setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void removePromoCode() {
    _errorMsg = false;
    _promoIsActive = false;
    promoCodeController.clear();
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
    String isShalwata = "0",
  }) async {
    var _response;
    _dialogContext = context;
    _showDialogIndicator(context);
    try {
      _response = await CartRepository().addToCart({
        "product_id": "$productId",
        "quantity": "$quantity",
        "preparation_id": "$preparationId",
        "size_id": "$sizeId",
        "cut_id": "$cutId",
        "is_shalwata": "$isShalwata",
        "comment": "",
        "applied_discount_code": ""
      }, authorization);
      _cartLength += _response == 200 ? int.parse(quantity) : 0;
      showSnackBar(context,
          _response == 200 ? "product_added_cart" : "unexpected_error");
    } catch (e) {
      print(e.toString());
      showSnackBar(context, "unexpected_error");
    }
    Navigator.pop(_dialogContext!);
    notifyListeners();
  }

  //update cart item
  Future<void> updateCartItem({
    required BuildContext context,
    required String productId,
    required String quantity,
  }) async {
    var _response;
    _dialogContext = context;
    _showDialogIndicator(context);
    try {
      _response = await CartRepository().updateCartItem({
        "quantity": "$quantity",
        "comment": "",
      }, "Bearer $_authorization", productId);
      if (_response == 200) {
        await getCartData(_authorization!, isLoading: false);
      } else
        showSnackBar(context, "unexpected_error");
    } catch (e) {
      print('catch');
      print(e.toString());
      showSnackBar(context, "unexpected_error");
    }
    Navigator.pop(_dialogContext!);
  }

  //delete cart item
  Future<void> deleteCartItem({
    required BuildContext context,
    required String productId,
  }) async {
    var _response;
    _dialogContext = context;
    _showDialogIndicator(context);
    try {
      _response = await CartRepository()
          .deleteCartItem("Bearer $_authorization", productId);
      if (_response == 200) {
        await getCartData(_authorization!, isLoading: false);
      } else
        showSnackBar(context, "unexpected_error");
    } catch (e) {
      print('catch');
      print(e.toString());
      showSnackBar(context, "unexpected_error");
    }
    Navigator.pop(_dialogContext!);
  }

  //getCartData
  Future<void> getCartData(String token, {bool isLoading = true}) async {
    _authorization = token;
    _isLoading = isLoading;
    _retry = false;
    try {
      _cartData = await CartRepository().getCartList("Bearer $token");
      cartItems();

      if ((_cartData?.data?.cart?.data?.length ?? 0) >
          0) if (_cartData!.data!.cart!.data![0].appliedDiscountCode != null) {
        print('${_cartData!.data!.cart!.data![0].appliedDiscountCode}');
        promoCodeController.text =
            _cartData!.data!.cart!.data![0].appliedDiscountCode!;
        _errorMsg = false;
        _promoIsActive = true;
      }
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

  //check coupon
  Future<void> checkCoupon({
    required BuildContext context,
  }) async {
    _errorMsg = false;
    _promoIsActive = true;
    var _response;
    _dialogContext = context;
    _showDialogIndicator(context);
    try {
      _response = await CartRepository().checkCoupon({
        "code": promoCodeController.text.trim(),
      }, "Bearer $_authorization");
      if (_response == 200) {
        await getCartData(_authorization!, isLoading: false);
      } else
        _errorMsg = true;
    } catch (e) {
      print('catch');
      print(e.toString());
      showSnackBar(context, "unexpected_error");
    }
    Navigator.pop(_dialogContext!);
  }

  //placeOrder
  Future<void> placeOrder({
    required BuildContext context,
  }) async {
    if (_selectedDate == -1) {
      showSnackBar(context, "please_select_delivery_date");
      return;
    }
    if (_selectedTime == -1) {
      showSnackBar(context, "please_select_delivery_time");
      return;
    }
    if (_selectedPayment == -1) {
      showSnackBar(context, "please_choose_payment_method");
      return;
    }
    var _response;
    _dialogContext = context;
    _showDialogIndicator(context);
    try {
      _response = await OrderRepository().placeOrder({
        "delivery_date_id": 11,
        "delivery_period_id": 1,
        "using_wallet": 0,
        "payment_type_id": 1,
        "address_id": 20
      }, "Bearer $_authorization");
      if (_response == 200) {
        _errorMsg = false;
        _promoIsActive = true;
        _selectedPayment = -1;
        _selectedDate = -1;
        _selectedTime = -1;
        _cartData = null;
        notifyListeners();
        Navigator.pop(_dialogContext!);

        Navigator.of(context, rootNavigator: true).push(
          MaterialPageRoute(builder: (BuildContext context) => OrderSuccess()),
        );
      } else {
        Navigator.pop(_dialogContext!);
        showSnackBar(context, "unexpected_error");
      }
    } catch (e) {
      print('catch');
      print(e.toString());
      showSnackBar(context, "unexpected_error");
      Navigator.pop(_dialogContext!);
    }
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

  double getPrice(int index) {
    double price = 0.0;
    if (_cartData!.data!.cart!.data![index].size == null) {
      if (double.parse(
              _cartData!.data!.cart!.data![index].product!.salePrice!) >
          0.0) {
        price += double.parse(
            _cartData!.data!.cart!.data![index].product!.salePrice!);
      } else {
        price +=
            double.parse(_cartData!.data!.cart!.data![index].product!.price!);
      }
    } else {
      if (double.parse(_cartData!.data!.cart!.data![index].size!.salePrice!) >
          0.0) {
        price +=
            double.parse(_cartData!.data!.cart!.data![index].size!.salePrice!);
      } else {
        price += double.parse(_cartData!.data!.cart!.data![index].size!.price!);
      }
    }

    if (_cartData!.data!.cart!.data![index].shalwata != null) {
      price +=
          double.parse(_cartData!.data!.cart!.data![index].shalwata!.price!);
    }
    return price;
  }

  void cartItems() {
    _cartLength = 0;
    for (int i = 0; i < ((_cartData?.data?.cart?.data?.length) ?? 0); i++) {
      print('$i');
      print('$i');
      _cartLength += _cartData!.data!.cart!.data![i].quantity!;
    }
    // return _cartLength;
  }
}
