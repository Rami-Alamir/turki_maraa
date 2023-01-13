import 'extra.dart';
import 'invoice_preview.dart';
import 'product.dart';

class CartData {
  Data? data;
  CartData({this.data});
  CartData.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  Cart? cart;
  List<MinOrder>? minOrder;
  List<NotIncludedDates>? notIncludedDates;
  InvoicePreview? invoicePreview;
  Data({this.cart, this.invoicePreview, this.notIncludedDates, this.minOrder});
  Data.fromJson(Map<String, dynamic> json) {
    if (json['not_included_dates'] != null) {
      notIncludedDates = <NotIncludedDates>[];
      json['not_included_dates'].forEach((v) {
        notIncludedDates!.add(NotIncludedDates.fromJson(v));
      });
    }
    cart = json['cart'] != null ? Cart.fromJson(json['cart']) : null;
    if (json['min_order'] != null) {
      minOrder = <MinOrder>[];
      json['min_order'].forEach((v) {
        minOrder!.add(MinOrder.fromJson(v));
      });
    }
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

  ItemData(
      {this.id,
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
      this.shalwata});

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
    product =
        json['product'] != null ? ProductData.fromJson(json['product']) : null;
    preparation = json['preparation'] != null
        ? ExtraData.fromJson(json['preparation'])
        : null;
    size = json['size'] != null ? ExtraData.fromJson(json['size']) : null;
    cut = json['cut'] != null ? ExtraData.fromJson(json['cut']) : null;
    shalwata =
        json['shalwata'] != null ? ExtraData.fromJson(json['shalwata']) : null;
  }
}

class MinOrder {
  int? countryId;
  String? minOrder;

  MinOrder({this.countryId, this.minOrder});

  MinOrder.fromJson(Map<String, dynamic> json) {
    countryId = json['country_id'];
    minOrder = json['min_order'];
  }
}

class NotIncludedDates {
  String? deliveryDate;

  NotIncludedDates({this.deliveryDate});

  NotIncludedDates.fromJson(Map<String, dynamic> json) {
    deliveryDate = json['delivery_date'];
  }
}
