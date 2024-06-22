import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tabby_flutter_inapp_sdk/tabby_flutter_inapp_sdk.dart';
import 'package:crypto/crypto.dart';
import 'address_provider.dart';
import '../presentation/widgets/dialog/message_dialog.dart';
import '../models/payment_types.dart';
import '../models/tabby_captures.dart';
import '../models/user_data.dart';
import '../models/cart_data.dart';
import '../models/delivery_period.dart';
import '../models/payment_arb.dart';
import '../models/tamara_data.dart';
import '../models/order_ref.dart';
import '../models/tamara_payment.dart';
import '../core/constants/constants.dart';
import '../core/constants/fixed_assets.dart';
import '../core/service/firebase_helper.dart';
import '../core/service/service_locator.dart';
import '../core/utilities/dialog_helper.dart';
import '../core/utilities/enum/request_status.dart';
import '../core/utilities/app_localizations.dart';
import '../core/utilities/calculate_helper.dart';
import '../core/utilities/get_strings.dart';
import '../repository/booking_repository.dart';
import '../repository/cart_repository.dart';
import '../repository/order_repository.dart';
import '../repository/tamara_repository.dart';
import '../repository/payment_repository.dart';
import '../repository/tabby_repository.dart';

class CartProvider with ChangeNotifier {
  final ScrollController _scrollController = ScrollController();
  TextEditingController noteController = TextEditingController();
  TextEditingController promoCodeController = TextEditingController();
  RequestStatus _requestStatus = RequestStatus.isLoading;
  //used with promo code
  bool _errorMsg = false;
  bool _promoIsActive = false;
  CartData? _cartData;
  TamaraData? _tamaraData;
  String? _authorization;
  UserData? _userData;
  Payment? _mockPayload;
  TabbyCaptures? tabbyCaptures;
  bool _useCredit = false;
  int _selectedPayment = -1;
  int _selectedDate = -1;
  int _selectedTime = -1;
  int _cartLength = 0;
  bool _isAuth = false;
  bool _cashAvailable = true;
  bool _onlineAvailable = true;
  bool _tamaraAvailable = true;
  bool _tabbyAvailable = true;
  LatLng? _latLng;
  String? _isoCountryCode;
  String? selectedAddress;
  final List<DateTime> _deliveryDataTime = [];

  DeliveryPeriod? _deliveryPeriod;
  String? _currentLocationDescriptionAr = '';
  String? _currentLocationDescriptionEn = '';
  late TabbySession session;
  late TamaraPayment tamara;
  late PaymentARB arb;
  late OrderRef orderRef;
  PaymentTypes? _paymentTypes;

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
  CartData? get cartData => _cartData;
  int get selectedPayment => _selectedPayment;
  int get selectedTime => _selectedTime;
  bool get useCredit => _useCredit;
  bool get errorMsg => _errorMsg;
  bool get promoIsActive => _promoIsActive;
  RequestStatus get requestStatus => _requestStatus;
  PaymentTypes? get paymentTypes => _paymentTypes;

  bool get cashAvailable => _cashAvailable;

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

  // used to update cart provider
  void updateCartProvider(
      String accessToken,
      bool isAuth,
      LatLng? latLng,
      UserData? userData,
      String? isoCountryCode,
      String? currentLocationDescriptionAr,
      String? currentLocationDescriptionEn) {
    _currentLocationDescriptionAr = currentLocationDescriptionAr;
    _currentLocationDescriptionEn = currentLocationDescriptionEn;
    _authorization = "Bearer $accessToken";
    _isAuth = isAuth;
    _userData = userData;
    _isoCountryCode = isoCountryCode;
    if (!_isAuth) {
      _cartLength = 0;
      _latLng = latLng;
      _requestStatus = RequestStatus.completed;
      notifyListeners();
    } else if (latLng != null) {
      if (latLng != _latLng) {
        _latLng = latLng;
        _cartLength = 0;
        notifyListeners();
      }
    }
  }

  void removePromoCode() {
    _errorMsg = false;
    _promoIsActive = false;
    promoCodeController.clear();
    notifyListeners();
  }

  Future<bool> addToCart({
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
    sl<DialogHelper>().showIndicatorDialog(context);
    try {
      response = await sl<CartRepository>().addToCart({
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
        await getCartData();
      } else {
        return false;
      }
      return true;
    } catch (_) {}
    notifyListeners();
    return false;
  }

  Future<bool> updateCartItem({
    required BuildContext context,
    required String productId,
    required String quantity,
  }) async {
    HapticFeedback.heavyImpact();
    sl<DialogHelper>().showIndicatorDialog(context);
    try {
      int response = await sl<CartRepository>().updateCartItem({
        "quantity": quantity,
        "comment": "",
      }, _authorization!, productId, _latLng!, _isoCountryCode!);
      if (response == 200) {
        await getCartData();
        return true;
      }
    } catch (_) {}
    return false;
  }

  Future<bool> deleteCartItem({
    required BuildContext context,
    required String productId,
  }) async {
    HapticFeedback.vibrate();
    sl<DialogHelper>().showIndicatorDialog(context);
    try {
      int response = await sl<CartRepository>().deleteCartItem(
          _authorization!, productId, _latLng!, _isoCountryCode!);
      if (response == 200) {
        await getCartData();
        return true;
      }
    } catch (_) {}
    return false;
  }

  // get cart items, Tamara status and Delivery periods
  Future<void> getCartData({bool isLoading = false}) async {
    if (_isAuth) {
      _requestStatus = RequestStatus.completed;
      if (isLoading) {
        _requestStatus = RequestStatus.isLoading;
        notifyListeners();
      }
      try {
        await Future.wait(
            [_getDeliveryPeriods(), _getCart(), _getPaymentTypes()]);

        await getTamaraData();
        _cartLength = sl<CalculateHelper>()
            .calculateCartLength(_cartData?.data?.cart?.data);
        if ((_cartData?.data?.cart?.data?.length ?? 0) > 0) {
          if (_cartData!.data!.cart!.data![0].appliedDiscountCode != null) {
            promoCodeController.text =
                _cartData!.data!.cart!.data![0].appliedDiscountCode!;
            _errorMsg = false;
            _promoIsActive = true;
          }
        }
        _requestStatus = RequestStatus.completed;
      } catch (_) {
        _requestStatus = RequestStatus.error;
      }
      notifyListeners();
    }
  }

  Future<void> getTamaraData() async {
    try {
      _tamaraData = null;
      _tamaraData = await sl<TamaraRepository>().getTamaraStatus(
          _isoCountryCode!,
          sl<GetStrings>().getCurrency('en', _isoCountryCode!),
          _cartData!.data!.invoicePreview!.totalAmountAfterDiscount!
              .toString());
    } catch (_) {}
  }

  Future<void> _getCart() async {
    _cartData = await sl<CartRepository>()
        .getCartList(_authorization!, _latLng!, _isoCountryCode!);
  }

  Future<void> _getPaymentTypes() async {
    _cashAvailable = true;
    _onlineAvailable = true;
    _tabbyAvailable = true;
    _tamaraAvailable = true;
    if (_isoCountryCode == 'SA') {
      _paymentTypes = await sl<PaymentRepository>().getPaymentTypes();
      for (int i = 0; i < (paymentTypes?.data?.length ?? 0); i++) {
        if (paymentTypes!.data![i].id == 1 &&
            paymentTypes!.data![i].active == 0) {
          _cashAvailable = false;
        }
        if (paymentTypes!.data![i].id == 2 &&
            paymentTypes!.data![i].active == 0) {
          _onlineAvailable = false;
        }
        if (paymentTypes!.data![i].id == 4 &&
            paymentTypes!.data![i].active == 0) {
          _tamaraAvailable = false;
        }
        if (paymentTypes!.data![i].id == 7 &&
            paymentTypes!.data![i].active == 0) {
          _tabbyAvailable = false;
        }
      }
    }
  }

  Future<void> _getDeliveryPeriods() async {
    _deliveryPeriod = await sl<BookingRepository>().getDeliveryPeriods();
  }

  Future<bool> checkCoupon({required BuildContext context}) async {
    _errorMsg = false;
    _promoIsActive = true;
    int response;
    sl<DialogHelper>().showIndicatorDialog(context);
    HapticFeedback.heavyImpact();

    try {
      response = await sl<CartRepository>().checkCoupon(
          _latLng!,
          _isoCountryCode!,
          {
            "code": promoCodeController.text.trim(),
          },
          _authorization!);
      if (response == 200) {
        await getCartData();
      } else {
        _errorMsg = true;
        notifyListeners();
      }
      return true;
    } catch (_) {}
    return false;
  }

  Future<int> placeOrder(
      {required BuildContext context,
      required String currency,
      required int addressId,
      List<String>? dates,
      List<bool>? cutStatus,
      int? cutId = 15,
      required Lang language}) async {
    http.Response response;
    bool status = checkRequiredData(context);
    if (status) {
      try {
        // check if user have selected address if not add new address
        if (addressId == -1) {
          final AddressProvider addressProvider =
              Provider.of<AddressProvider>(context, listen: false);
          await addressProvider.addNewAddress(context,
              latLng: _latLng, isoCountryCode: _isoCountryCode);
          addressId = addressProvider.userAddress!.data!.last.id!;
        }
        // DateFormat format = DateFormat('MM-dd');
        DateFormat format = DateFormat('yyyy-MM-dd');
        // DateFormat format = DateFormat('dd-MM-yyyy');
        response = await sl<OrderRepository>().placeOrder({
          "delivery_date": format.format(deliveryDataTime[_selectedDate]),
          "delivery_period_id": _deliveryPeriod!.data![_selectedTime].id,
          "using_wallet": 0,
          if (_selectedPayment == 4)
            "tamara_payment_name": "PAY_BY_INSTALMENTS",
          if (_selectedPayment == 4) "no_instalments": 3,
          "comment": " ${noteController.text}",
          "payment_type_id": _selectedPayment,
          "address_id": addressId
        }, _authorization!, _latLng!, _isoCountryCode!);
        var paymentId = _selectedPayment;
        if (response.statusCode == 200) {
          FirebaseHelper()
              .pushAnalyticsEvent(name: "notes", value: noteController.text);
          if (paymentId == 1) {
            return 1;
          } else if (paymentId == 2) {
            arb = PaymentARB.fromJson(json.decode(response.body.toString()));
            return 2;
          } else if (paymentId == 4) {
            tamara =
                TamaraPayment.fromJson(json.decode(response.body.toString()));
            return 4;
          } else if (paymentId == 7) {
            orderRef = OrderRef.fromJson(json.decode(response.body.toString()));
            await initTabby(language);
            return 7;
          }
        } else {
          _cartLength = 0;
          _cartData = null;
          notifyListeners();
          return 0;
        }
      } catch (_) {
        return 0;
      }
    }
    return -1;
  }

  Future<void> initTabby(Lang language) async {
    final String email =
        (_userData?.data?.email ?? "user${_userData?.data?.id}@turkieshop.com")
            .trim();
    _mockPayload = Payment(
      amount:
          _cartData!.data!.invoicePreview!.totalAmountAfterDiscount!.toString(),
      currency: _isoCountryCode == "SA" ? Currency.sar : Currency.aed,
      buyer: Buyer(
        email: email.length > 10
            ? email
            : "user${_userData?.data?.id}@turkieshop.com",
        phone: _userData!.data!.mobile!.substring(4),
        name: _userData?.data?.name ?? "user${_userData?.data?.id}",
        dob: '1995-01-30',
      ),
      buyerHistory: BuyerHistory(
        loyaltyLevel: 0,
        registeredSince: _userData!.data!.createdAt!,
        wishlistCount: 0,
      ),
      shippingAddress: ShippingAddress(
        city: _isoCountryCode!,
        address: (selectedAddress ?? " "),
        zip: '12345',
      ),
      order:
          Order(referenceId: orderRef.data!.orderRef!, items: _getOrderItems()),
      orderHistory: [
        OrderHistoryItem(
          purchasedAt: '2019-08-24T14:15:22Z',
          amount: _cartData!.data!.invoicePreview!.totalAmountAfterDiscount!
              .toString(),
          paymentMethod: OrderHistoryItemPaymentMethod.card,
          status: OrderHistoryItemStatus.newOne,
        )
      ],
    );
    session = await TabbySDK().createSession(TabbyCheckoutPayload(
      merchantCode: _isoCountryCode == "SA"
          ? Constants.tabbyMerchantCodeSA
          : Constants.tabbyMerchantCodeAE,
      lang: language,
      payment: _mockPayload!,
    ));
  }

  //capture tabby payment
  Future<bool> capturePayment(String id) async {
    try {
      tabbyCaptures = await sl<TabbyRepository>().capturePayment({
        "amount": _mockPayload!.amount,
      }, _isoCountryCode == "SA" ? 'TD_APP' : 'TD_APPAE', id);
      if (tabbyCaptures?.status == "CLOSED") {
        await _updateTabbyPaymentStatus();
      }
      return true;
    } catch (_) {
      return false;
    }
  }

  // used in tabby payment
  List<OrderItem> _getOrderItems() {
    List<OrderItem> orderItems = [];
    for (int i = 0; i < cartData!.data!.cart!.data!.length; i++) {
      final ItemData item = cartData!.data!.cart!.data![i];
      orderItems.add(OrderItem(
        title: item.product!.nameEn!,
        description: item.product!.nameEn!,
        quantity: item.quantity!,
        unitPrice: item.product!.salePrice!.toString(),
        referenceId: item.product!.id!.toString(),
        productUrl: 'http://example.com',
        category: item.product!.nameEn!,
      ));
    }
    return orderItems;
  }

  Future<void> _updateTabbyPaymentStatus() async {
    try {
      await sl<PaymentRepository>().updateOrderPayment({
        "bank_ref": "${tabbyCaptures?.id}",
        "payment_ref": orderRef.data!.paymentRef!,
        "order_ref": "${orderRef.data!.orderRef}",
        "paid": "1",
        "sauce": _encryptTabbyPayment()
      }, _authorization!);
    } catch (_) {
      throw Exception();
    }
  }

  String _encryptTabbyPayment() {
    var bytes = utf8.encode("${json.encode({
          "bank_ref": "${tabbyCaptures?.id}",
          "payment_ref": orderRef.data!.paymentRef!,
          "order_ref": "${orderRef.data!.orderRef}",
          "paid": "1",
        })}330b838b-6c2a-450d-8e2e-0cde4c38abb6");
    final sauce = sha512.convert(bytes);
    return base64.encode(utf8.encode("$sauce"));
  }

  // check required data to move screen controller to required fields
  bool checkRequiredData(BuildContext context) {
    double offset = sl<CalculateHelper>()
        .calculateOffset(_cartData!.data!.cart!.data!.length);
    if (_selectedDate == -1) {
      animateScrollController(context, offset);
      return false;
    }
    if (_selectedTime == -1) {
      animateScrollController(context, offset + 135);
      return false;
    }
    if (_selectedPayment == -1) {
      animateScrollController(context, offset + 235);
      return false;
    }
    sl<DialogHelper>().showIndicatorDialog(context);
    return true;
  }

  // animate scrollController to required fields and show message
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
    sl<DialogHelper>().show(
        context,
        MessageDialog(
          message: message,
          image: FixedAssets.warning,
        ));
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

  void clearCart() {
    _errorMsg = false;
    _promoIsActive = false;
    initSomeValues();
    _cartData = null;
    _cartLength = 0;
    promoCodeController.clear();
    noteController.clear();
    notifyListeners();
  }

  bool get onlineAvailable => _onlineAvailable;

  bool get tamaraAvailable => _tamaraAvailable;

  bool get tabbyAvailable => _tabbyAvailable;
}
