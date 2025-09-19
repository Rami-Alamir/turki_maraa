import 'delivery_period.dart';
import 'extra.dart';
import 'invoice_preview.dart';
import 'product.dart';

class CartData {
  Data? data;
  CurrentCity? currentCity;
  CartData({this.data, this.currentCity});
  CartData.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    currentCity = json['currentCity'] != null
        ? CurrentCity.fromJson(json['currentCity'])
        : null;
  }
}

class Data {
  Cart? cart;
  InvoicePreview? invoicePreview;
  double? customerWallet;
  double? cashTurki;

  Data({this.cart, this.invoicePreview, this.customerWallet});
  Data.fromJson(Map<String, dynamic> json) {
    cart = json['cart'] != null ? Cart.fromJson(json['cart']) : null;
    customerWallet = double.parse(json['customer_wallet'] ?? "0.0");
    cashTurki = (json['cash_turki'] ?? 0) * 1.0;
    invoicePreview = json['invoice-preview'] != null
        ? InvoicePreview.fromJson(json['invoice-preview'])
        : null;
  }
}

class Cart {
  List<ItemData>? data;
  int? total;
  Cart({this.data, this.total});
  Cart.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ItemData>[];
      json['data'].forEach((v) {
        data!.add(ItemData.fromJson(v));
      });
    }
    total = json['total'];
  }
}

class ItemData {
  int? id;
  String? comment;
  String? appliedDiscountCode;
  int? isShalwata;
  int? productId;
  int? quantity;
  ProductData? product;
  ExtraData? preparation;
  ExtraData? size;
  ExtraData? cut;
  ExtraData? shalwata;
  bool? isKwar3;
  bool? isRas;
  bool? isLyh;
  bool? isKarashah;

  ItemData({
    this.id,
    this.comment,
    this.appliedDiscountCode,
    this.isKwar3,
    this.isRas,
    this.isLyh,
    this.isKarashah,
    this.isShalwata,
    this.productId,
    this.quantity,
    this.product,
    this.preparation,
    this.size,
    this.cut,
    this.shalwata,
  });

  ItemData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comment = json['comment'];
    appliedDiscountCode = json['applied_discount_code'];
    isKwar3 = json['is_kwar3'] ?? false;
    isRas = json['is_Ras'] ?? false;
    isLyh = json['is_lyh'] ?? false;
    isKarashah = json['is_karashah'] ?? false;
    isShalwata = json['is_shalwata'];
    productId = json['product_id'];
    quantity = json['quantity'];
    product = json['product'] != null
        ? ProductData.fromJson(json['product'])
        : null;
    preparation = json['preparation'] != null
        ? ExtraData.fromJson(json['preparation'])
        : null;
    size = json['size'] != null ? ExtraData.fromJson(json['size']) : null;
    cut = json['cut'] != null ? ExtraData.fromJson(json['cut']) : null;
    shalwata = json['shalwata'] != null
        ? ExtraData.fromJson(json['shalwata'])
        : null;
  }
}

class CurrentCity {
  int? id;
  String? nameEn;
  String? nameAr;
  bool? allowCash;
  double? minPrice;
  List<String>? dates;
  List<DeliveryPeriodData>? deliveryPeriod;

  CurrentCity({
    this.id,
    this.nameEn,
    this.nameAr,
    this.allowCash,
    this.minPrice,
    this.dates,
    this.deliveryPeriod,
  });

  CurrentCity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    allowCash = json['allow_cash'];
    minPrice = double.parse(json['min_price'] ?? '0.0');
    dates = json['dates'].cast<String>();
    if (json['delivery_period'] != null) {
      deliveryPeriod = <DeliveryPeriodData>[];
      json['delivery_period'].forEach((v) {
        deliveryPeriod!.add(DeliveryPeriodData.fromJson(v));
      });
    }
  }
}

class NotIncludedDates {
  String? deliveryDate;

  NotIncludedDates({this.deliveryDate});

  NotIncludedDates.fromJson(Map<String, dynamic> json) {
    deliveryDate = json['delivery_date'];
  }
}
