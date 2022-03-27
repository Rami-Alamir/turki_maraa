import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:new_turki/models/cart_data.dart';
import 'package:new_turki/models/payment_arb.dart';
import 'package:new_turki/provider/home_provider.dart';
import 'package:new_turki/repository/booking_repository.dart';
import 'package:new_turki/repository/cart_repository.dart';
import 'package:new_turki/repository/order_repository.dart';
import 'package:new_turki/repository/user_repository.dart';
import 'package:new_turki/screens/orders/order_success.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:new_turki/widgets/dialog/indicator_dialog.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/delivery_period.dart';
import '../widgets/dialog/message_dialog.dart';
import 'address_provider.dart';

class CartProvider with ChangeNotifier {
  ScrollController _scrollController = ScrollController();
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
  LatLng? _latLng;
  String? _isoCountryCode;
  List<DateTime> _deliveryDataTime = [];
  DeliveryPeriod? _deliveryPeriod;

  DeliveryPeriod get deliveryPeriod => _deliveryPeriod!;
  String get isoCountryCode => _isoCountryCode!;
  ScrollController get scrollController => _scrollController;
  List<DateTime> get deliveryDataTime => _deliveryDataTime;
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
    required LatLng latLng,
    required String isoCountryCode,
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
      }, authorization, latLng, isoCountryCode);
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
      }, "Bearer $_authorization", productId, _latLng!, _isoCountryCode!);
      if (_response == 200) {
        await getCartData(_authorization!, _latLng!, _isoCountryCode!,
            isLoading: false);
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
      _response = await CartRepository().deleteCartItem(
          "Bearer $_authorization", productId, _latLng!, _isoCountryCode!);
      if (_response == 200) {
        await getCartData(_authorization!, _latLng!, _isoCountryCode!,
            isLoading: false);
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
  Future<void> getCartData(String token, LatLng latLng, String countryId,
      {bool isLoading = true}) async {
    print('getCartData');
    if (latLng == LatLng(13.271186675142177, 54.353398606181145)) {
      isLoading = false;
      _retry = false;
      notifyListeners();
      return;
    } else {
      _authorization = token;
      _isLoading = isLoading;
      _latLng = latLng;
      _isoCountryCode = countryId;
      _retry = false;
      try {
        _cartData = await CartRepository()
            .getCartList("Bearer $token", latLng, countryId);
        _deliveryPeriod = await BookingRepository().getDeliveryPeriods();
        cartItems();
        if ((_cartData?.data?.cart?.data?.length ?? 0) > 0) if (_cartData!
                .data!.cart!.data![0].appliedDiscountCode !=
            null) {
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
  }

  void showSnackBar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
      AppLocalizations.of(context)!.tr(msg),
      textAlign: TextAlign.center,
    )));
  }

  //check coupon
  Future<void> checkCoupon({required BuildContext context}) async {
    _errorMsg = false;
    _promoIsActive = true;
    var _response;
    _dialogContext = context;
    _showDialogIndicator(context);
    try {
      _response = await CartRepository().checkCoupon(
          _latLng!,
          _isoCountryCode!,
          {
            "code": promoCodeController.text.trim(),
          },
          "Bearer $_authorization");
      if (_response == 200) {
        await getCartData(_authorization!, _latLng!, _isoCountryCode!,
            isLoading: false);
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
  Future<void> placeOrder(
      {required BuildContext context,
      required String currency,
      required int addressId}) async {
    if (_cartData!.data!.invoicePreview!.totalAmountAfterDiscount! <
        double.parse((_cartData!.data?.minOrder?.first.minOrder) ?? '60'))
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        AppLocalizations.of(context)!.tr('the_minimum_order_amount_is') +
            "${_cartData!.data!.minOrder!.first.minOrder} $currency",
        textAlign: TextAlign.center,
      )));
    else {
      double _offset = calculateOffset();
      if (_selectedDate == -1) {
        animateScrollController(context, _offset);
        return;
      }
      if (_selectedTime == -1) {
        animateScrollController(context, _offset + 135);
        return;
      }
      if (_selectedPayment == -1) {
        animateScrollController(context, _offset + 235);
        return;
      }
      var _response;
      _dialogContext = context;
      _showDialogIndicator(context);
      try {
        if (addressId == -1) {
          final _homeProvider =
              Provider.of<HomeProvider>(context, listen: false);
          final _addressProvider =
              Provider.of<AddressProvider>(context, listen: false);
          final address = "${_homeProvider.currentLocationDescription}";
          var _response = await UserRepository().addAddress({
            "country_iso_code": _isoCountryCode,
            "address": address.isEmpty ? ".." : address,
            "comment": address.isEmpty ? ".." : address,
            "label": "label",
            "is_default": "0",
            "long": "${_homeProvider.locationData.longitude}",
            "lat": "${_homeProvider.locationData.latitude}",
          }, "Bearer $_authorization");
          print(_response.body.toString());
          if (_response.statusCode == 200) {
            await _addressProvider.getAddressList("Bearer $_authorization");
            _addressProvider.setSelectedAddress =
                (_addressProvider.userAddress?.data?.length ?? 0) - 1;
            addressId = _addressProvider.userAddress!.data!.last.id!;
          } else {
            Navigator.pop(_dialogContext!);
            throw Exception;
          }
        }
        DateFormat format = DateFormat('MM-dd');
        _response = await OrderRepository().placeOrder({
          "delivery_date": "${format.format(deliveryDataTime[_selectedDate])}",
          "delivery_period_id": _isoCountryCode == 'AE'
              ? (_selectedTime + 1)
              : _deliveryPeriod!.data![_selectedTime].id,
          "using_wallet": 0,
          "comment": "${noteController.text}",
          "payment_type_id": _selectedPayment,
          "address_id": addressId
        }, "Bearer $_authorization", _latLng!, _isoCountryCode!);
        var paymentId = _selectedPayment;
        if (_response.statusCode == 200) {
          _errorMsg = false;
          _promoIsActive = false;
          _selectedPayment = -1;
          _selectedDate = -1;
          _selectedTime = -1;
          _cartData = null;
          _cartLength = 0;
          promoCodeController.clear();
          notifyListeners();
          Navigator.pop(_dialogContext!);
          Navigator.of(context, rootNavigator: true).push(
            MaterialPageRoute(
                builder: (BuildContext context) => OrderSuccess(
                      paymentType: paymentId,
                    )),
          );
          if (paymentId > 1) {
            PaymentARB arb =
                PaymentARB.fromJson(json.decode(_response.body.toString()));
            await launch(arb.data!.invoiceURL!, forceSafariVC: true);
            notifyListeners();
          } else
            notifyListeners();
        } else {
          _cartLength = 0;
          Navigator.pop(_dialogContext!);
          notifyListeners();
          showSnackBar(context, "unexpected_error");
        }
      } catch (e) {
        print('catch');
        print(e.toString());
        showSnackBar(context, "unexpected_error");
        Navigator.pop(_dialogContext!);
      }
    }
  }

  // used to calculate value of offset
  double calculateOffset() {
    double offset = _cartData!.data!.cart!.data!.length *
        (SizeConfig.screenWidth! < 600 ? 130 : 165);
    offset += 160;
    return offset;
  }

  // animate scrollController to offset
  void animateScrollController(BuildContext context, double offset) {
    _scrollController.animateTo(offset,
        curve: Curves.linear, duration: Duration(milliseconds: 250));
    String message = AppLocalizations.of(context)!.tr("please_select");
    if (_selectedDate == -1) {
      message += AppLocalizations.of(context)!.tr("delivery_date");
    }
    if (_selectedTime == -1) {
      if (message != AppLocalizations.of(context)!.tr("please_select"))
        message += AppLocalizations.of(context)!.tr("and");
      message += AppLocalizations.of(context)!.tr("delivery_time");
    }
    if (_selectedPayment == -1) {
      if (message != AppLocalizations.of(context)!.tr("please_select"))
        message += AppLocalizations.of(context)!.tr("and");
      message += AppLocalizations.of(context)!.tr("payment_method");
    }

    _showAlertDialog(context, message);
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

  // show alert dialog
  void _showAlertDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return MessageDialog(message: message);
      },
    );
  }

  // get price
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

  void initDateTimeList() {
    DateTime dt = DateTime.now();
    for (int i = 0; i < 21; i++) {
      _deliveryDataTime.add(DateTime(dt.year, dt.month, (dt.day + i)));
    }
  }
}
