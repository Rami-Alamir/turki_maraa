import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../core/constants/fixed_assets.dart';
import '/../core/service/firebase_helper.dart';
import '/../core/utilities/app_localizations.dart';
import '/../core/utilities/calculate_helper.dart';
import '/../core/utilities/get_strings.dart';
import '/../core/utilities/show_snack_bar.dart';
import '/../models/cart_data.dart';
import '/../models/delivery_period.dart';
import '/../models/payment_arb.dart';
import '/../models/tamara_data.dart';
import '/../models/tamara_payment.dart';
import '/../presentation/screens/cart/order_success.dart';
import '/../presentation/screens/cart/tamara_checkout_page.dart';
import '/../presentation/widgets/dialog/indicator_dialog.dart';
import '/../presentation/widgets/dialog/message_dialog.dart';
import '/../repository/booking_repository.dart';
import '/../repository/cart_repository.dart';
import '/../repository/order_repository.dart';
import '/../repository/tamara_repository.dart';
import 'address_provider.dart';

class CartProvider with ChangeNotifier {
  final ScrollController _scrollController = ScrollController();
  TextEditingController noteController = TextEditingController();
  TextEditingController promoCodeController = TextEditingController();
  bool _isLoading = true;
  bool _retry = false;
  //used with promo code
  bool _errorMsg = false;
  bool _promoIsActive = false;
  CartData? _cartData;
  String? _authorization;
  bool _useCredit = false;
  int _selectedPayment = -1;
  int _selectedDate = -1;
  int _selectedTime = -1;
  int _cartLength = 0;
  bool _isAuth = false;
  BuildContext? _dialogContext;
  TamaraData? _tamaraData;
  LatLng? _latLng;
  String? _isoCountryCode;
  final List<DateTime> _deliveryDataTime = [];
  DeliveryPeriod? _deliveryPeriod;
  String? _currentLocationDescriptionAr = '';
  String? _currentLocationDescriptionEn = '';

  LatLng? get latLng => _latLng;
  String? get currentLocationDescriptionAr => _currentLocationDescriptionAr;
  String? get currentLocationDescriptionEn => _currentLocationDescriptionEn;
  TamaraData? get tamaraData => _tamaraData;
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

  // used to update cart provider
  void updateCartProvider(
      String accessToken,
      bool isAuth,
      LatLng? latLng,
      String? isoCountryCode,
      String? currentLocationDescriptionAr,
      String? currentLocationDescriptionEn) {
    _currentLocationDescriptionAr = currentLocationDescriptionAr;
    _currentLocationDescriptionEn = currentLocationDescriptionEn;
    _authorization = "Bearer $accessToken";
    _isAuth = isAuth;
    _isoCountryCode = isoCountryCode;
    if (!_isAuth) {
      _cartLength = 0;
      _latLng = latLng;
      _isLoading = false;
      notifyListeners();
    } else if (latLng != null) {
      if (latLng != _latLng) {
        _latLng = latLng;
        _cartLength = 0;
        notifyListeners();
      }
    }
  }

  // used to remove and clear promo code
  void removePromoCode() {
    _errorMsg = false;
    _promoIsActive = false;
    promoCodeController.clear();
    notifyListeners();
  }

  //add item to cart
  Future<void> addToCart({
    required BuildContext context,
    required String productId,
    required String quantity,
    String preparationId = '',
    String sizeId = '',
    String cutId = '',
    String isShalwata = "0",
    String isRas = "0",
    String isLyh = "0",
    String iskarashah = "0",
    String iskwar3 = "0",
  }) async {
    int response;
    _dialogContext = context;
    _showDialogIndicator(context);
    try {
      response = await CartRepository().addToCart({
        "product_id": productId,
        "quantity": quantity,
        "preparation_id": preparationId,
        "size_id": sizeId,
        "cut_id": cutId,
        "is_Ras": isRas,
        "is_lyh": isLyh,
        "is_karashah": iskarashah,
        "is_kwar3": iskwar3,
        "is_shalwata": isShalwata,
        "comment": "",
        "applied_discount_code": ""
      }, _authorization!, _latLng!, _isoCountryCode!);
      _cartLength += response == 200 ? int.parse(quantity) : 0;
      if (response == 200) {
        await getCartData(isLoading: false);
      }
      // ignore: use_build_context_synchronously
      ShowSnackBar().show(
          context, response == 200 ? "product_added_cart" : "unexpected_error");
    } catch (e) {
      ShowSnackBar().show(context, "unexpected_error");
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
    int response;
    _dialogContext = context;
    _showDialogIndicator(context);
    try {
      response = await CartRepository().updateCartItem({
        "quantity": quantity,
        "comment": "",
      }, _authorization!, productId, _latLng!, _isoCountryCode!);
      if (response == 200) {
        await getCartData(isLoading: false);
      } else {
        // ignore: use_build_context_synchronously
        ShowSnackBar().show(context, "unexpected_error");
      }
    } catch (e) {
      ShowSnackBar().show(context, "unexpected_error");
    }
    Navigator.pop(_dialogContext!);
  }

  //delete cart item
  Future<void> deleteCartItem({
    required BuildContext context,
    required String productId,
  }) async {
    int response;
    _dialogContext = context;
    _showDialogIndicator(context);
    try {
      response = await CartRepository().deleteCartItem(
          _authorization!, productId, _latLng!, _isoCountryCode!);
      if (response == 200) {
        await getCartData(isLoading: false);
      } else {
        // ignore: use_build_context_synchronously
        ShowSnackBar().show(context, "unexpected_error");
      }
    } catch (e) {
      ShowSnackBar().show(context, "unexpected_error");
    }
    Navigator.pop(_dialogContext!);
  }

  //getCartData
  Future<void> getCartData({bool isLoading = true}) async {
    if (_isAuth) {
      _isLoading = isLoading;
      _retry = false;
      try {
        await Future.wait([getDeliveryPeriods(), getCart()]);
        await getTamaraData();
        _cartLength =
            CalculateHelper().calculateCartLength(_cartData?.data?.cart?.data);
        if ((_cartData?.data?.cart?.data?.length ?? 0) > 0) {
          if (_cartData!.data!.cart!.data![0].appliedDiscountCode != null) {
            promoCodeController.text =
                _cartData!.data!.cart!.data![0].appliedDiscountCode!;
            _errorMsg = false;
            _promoIsActive = true;
          }
        }
      } catch (e) {
        _retry = true;
      }
      _isLoading = false;
      notifyListeners();
    }
  }

  // get tamara status
  Future<void> getTamaraData() async {
    try {
      _tamaraData = null;
      _tamaraData = await TamaraRepository().getTamaraStatus(
          _isoCountryCode!,
          GetStrings().getCurrency('en', _isoCountryCode!),
          _cartData!.data!.invoicePreview!.totalAmountAfterDiscount!
              .toString());
    } catch (_) {}
  }

  // get cart items
  Future<void> getCart() async {
    try {
      _cartData = await CartRepository()
          .getCartList(_authorization!, _latLng!, _isoCountryCode!);
    } catch (e) {
      _retry = true;
    }
  }

  Future<void> getDeliveryPeriods() async {
    try {
      _deliveryPeriod = await BookingRepository().getDeliveryPeriods();
    } catch (e) {
      _retry = true;
    }
  }

  //check coupon
  Future<void> checkCoupon({required BuildContext context}) async {
    _errorMsg = false;
    _promoIsActive = true;
    int response;
    _dialogContext = context;
    _showDialogIndicator(context);
    try {
      response = await CartRepository().checkCoupon(
          _latLng!,
          _isoCountryCode!,
          {
            "code": promoCodeController.text.trim(),
          },
          _authorization!);
      if (response == 200) {
        await getCartData(isLoading: false);
      } else {
        _errorMsg = true;
      }
    } catch (e) {
      ShowSnackBar().show(context, "unexpected_error");
    }
    Navigator.pop(_dialogContext!);
  }

  //placeOrder
  Future<void> placeOrder(
      {required BuildContext context,
      required String currency,
      required int addressId}) async {
    // check required data
    double offset =
        CalculateHelper().calculateOffset(_cartData!.data!.cart!.data!.length);
    if (_selectedDate == -1) {
      animateScrollController(context, offset);
      return;
    }
    if (_selectedTime == -1) {
      animateScrollController(context, offset + 135);
      return;
    }
    if (_selectedPayment == -1) {
      animateScrollController(context, offset + 235);
      return;
    }
    http.Response response;
    _dialogContext = context;
    _showDialogIndicator(context);
    try {
      // check if user have selected address if not add new address
      if (addressId == -1) {
        final addressProvider =
            Provider.of<AddressProvider>(context, listen: false);
        await addressProvider.addNewAddress(context,
            latLng: _latLng, isoCountryCode: _isoCountryCode);
        addressId = addressProvider.userAddress!.data!.last.id!;
      }
      DateFormat format = DateFormat('MM-dd');
      response = await OrderRepository().placeOrder({
        "delivery_date": format.format(deliveryDataTime[_selectedDate]),
        "delivery_period_id": _isoCountryCode == 'AE'
            ? (_selectedTime + 1)
            : _deliveryPeriod!.data![_selectedTime].id,
        "using_wallet": 0,
        if (_selectedPayment == 4) "tamara_payment_name": "PAY_BY_INSTALMENTS",
        if (_selectedPayment == 4) "no_instalments": 3,
        "comment": " ${noteController.text}",
        "payment_type_id": _selectedPayment,
        "address_id": addressId
      }, _authorization!, _latLng!, _isoCountryCode!);
      var paymentId = _selectedPayment;
      if (response.statusCode == 200) {
        FirebaseHelper()
            .pushAnalyticsEvent(name: "notes", value: noteController.text);
        _errorMsg = false;
        _promoIsActive = false;
        initSomeValues();
        _cartData = null;
        _cartLength = 0;
        promoCodeController.clear();
        noteController.clear();
        notifyListeners();
        Navigator.pop(_dialogContext!);
        if (paymentId != 4) {
          // ignore: use_build_context_synchronously
          Navigator.of(context, rootNavigator: true).push(
            MaterialPageRoute(
                builder: (BuildContext context) => OrderSuccess(
                      paymentType: paymentId,
                    )),
          );
        }
        if (paymentId == 2) {
          PaymentARB arb =
              PaymentARB.fromJson(json.decode(response.body.toString()));
          await launchUrlString(arb.data!.invoiceURL!);
          notifyListeners();
        } else if (paymentId == 4) {
          TamaraPayment tamara =
              TamaraPayment.fromJson(json.decode(response.body.toString()));
          // ignore: use_build_context_synchronously
          Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
              builder: (BuildContext context) =>
                  TamaraCheckoutPage(checkoutUrl: tamara.data!.checkoutUrl!)));
          notifyListeners();
        } else {
          notifyListeners();
        }
      } else {
        _cartLength = 0;
        Navigator.pop(_dialogContext!);
        notifyListeners();
        // ignore: use_build_context_synchronously
        ShowSnackBar().show(context, "unexpected_error");
      }
    } catch (_) {
      ShowSnackBar().show(context, "unexpected_error");
      Navigator.pop(_dialogContext!);
    }
  }

  // animate scrollController to offset
  void animateScrollController(BuildContext context, double offset) {
    _scrollController.animateTo(offset,
        curve: Curves.linear, duration: const Duration(milliseconds: 250));
    String message = AppLocalizations.of(context)!.tr("please_select");
    if (_selectedDate == -1) {
      message += AppLocalizations.of(context)!.tr("delivery_date");
    }
    if (_selectedTime == -1) {
      if (message != AppLocalizations.of(context)!.tr("please_select")) {
        message += AppLocalizations.of(context)!.tr("and");
      }
      message += AppLocalizations.of(context)!.tr("delivery_time");
    }
    if (_selectedPayment == -1) {
      if (message != AppLocalizations.of(context)!.tr("please_select")) {
        message += AppLocalizations.of(context)!.tr("and");
      }
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
          return const IndicatorDialog();
        });
  }

  // show alert dialog
  void _showAlertDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return MessageDialog(
          message: message,
          image: FixedAssets.warning,
        );
      },
    );
  }

  void initDateTimeList() {
    DateTime dt = DateTime.now();
    for (int i = 0; i < 21; i++) {
      _deliveryDataTime.add(DateTime(dt.year, dt.month, (dt.day + i)));
    }
  }

  void initSomeValues() {
    _selectedTime = -1;
    _selectedPayment = -1;
    _selectedDate = -1;
  }
}
