class OrderModel {
  Data? data;

  OrderModel({this.data});

  OrderModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  Order? order;
  List<Products>? products;

  Data({this.order, this.products});

  Data.fromJson(Map<String, dynamic> json) {
    order = json['order'] != null ? Order.fromJson(json['order']) : null;
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
  }
}

class Order {
  int? id;
  String? refNo;
  String? deliveryFee;
  String? orderSubtotal;
  String? totalAmount;
  String? totalAmountAfterDiscount;
  String? comment;
  int? usingWallet;
  String? walletAmountUsed;
  String? cashTurkiUsed;
  String? appliedDiscountCode;
  String? discountApplied;
  int? addressId;
  int? customerId;
  int? orderStateId;
  int? paymentTypeId;
  int? deliveryPeriodId;
  String? deliveryDate;
  int? paymentId;
  int? versionApp;
  String? createdAt;
  String? updatedAt;
  PaymentType? paymentType;
  OrderState? orderState;
  DeliveryPeriod? deliveryPeriod;
  SelectedAddress? selectedAddress;

  Order({
    this.id,
    this.refNo,
    this.deliveryFee,
    this.orderSubtotal,
    this.totalAmount,
    this.totalAmountAfterDiscount,
    this.comment,
    this.usingWallet,
    this.walletAmountUsed,
    this.cashTurkiUsed,
    this.appliedDiscountCode,
    this.discountApplied,
    this.addressId,
    this.customerId,
    this.orderStateId,
    this.paymentTypeId,
    this.deliveryPeriodId,
    this.deliveryDate,
    this.paymentId,
    this.versionApp,
    this.createdAt,
    this.updatedAt,
    this.paymentType,
    this.orderState,
    this.deliveryPeriod,
    this.selectedAddress,
  });

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    refNo = json['ref_no'];
    deliveryFee = json['delivery_fee'];
    orderSubtotal = json['order_subtotal'];
    totalAmount = json['total_amount'];
    totalAmountAfterDiscount = json['total_amount_after_discount'];
    comment = json['comment'];
    usingWallet = json['using_wallet'];
    walletAmountUsed = json['wallet_amount_used'];
    cashTurkiUsed = json['cash_turki_used'];
    appliedDiscountCode = json['applied_discount_code'];
    discountApplied = json['discount_applied'];
    addressId = json['address_id'];
    customerId = json['customer_id'];
    orderStateId = json['order_state_id'];
    paymentTypeId = json['payment_type_id'];
    deliveryPeriodId = json['delivery_period_id'];
    deliveryDate = json['delivery_date'];
    paymentId = json['payment_id'];
    versionApp = json['version_app'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    paymentType = json['payment_type'] != null
        ? PaymentType.fromJson(json['payment_type'])
        : null;
    orderState = json['order_state'] != null
        ? OrderState.fromJson(json['order_state'])
        : null;
    deliveryPeriod = json['delivery_period'] != null
        ? DeliveryPeriod.fromJson(json['delivery_period'])
        : null;
    selectedAddress = json['selected_address'] != null
        ? SelectedAddress.fromJson(json['selected_address'])
        : null;
  }
}

class PaymentType {
  int? id;
  String? nameAr;
  String? nameEn;

  PaymentType({this.id, this.nameAr, this.nameEn});

  PaymentType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
  }
}

class OrderState {
  int? code;
  String? stateEn;
  String? stateAr;

  OrderState({this.code, this.stateEn, this.stateAr});

  OrderState.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    stateEn = json['state_en'];
    stateAr = json['state_ar'];
  }
}

class DeliveryPeriod {
  String? nameAr;
  String? nameEn;

  DeliveryPeriod({this.nameAr, this.nameEn});

  DeliveryPeriod.fromJson(Map<String, dynamic> json) {
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
  }
}

class SelectedAddress {
  String? address;
  String? comment;
  String? label;
  String? long;
  String? lat;

  SelectedAddress({
    this.address,
    this.comment,
    this.label,
    this.long,
    this.lat,
  });

  SelectedAddress.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    comment = json['comment'];
    label = json['label'];
    long = json['long'];
    lat = json['lat'];
  }
}

class Products {
  int? id;
  int? quantity;
  String? totalPrice;
  String? orderRefNo;
  bool? isKwar3;
  bool? isRas;
  bool? isLyh;
  bool? isKarashah;
  int? productId;
  String? createdAt;
  String? updatedAt;
  Extra? preparation;
  Extra? shalwata;
  Extra? size;
  Extra? cut;
  Product? product;

  Products({
    this.id,
    this.quantity,
    this.totalPrice,
    this.orderRefNo,
    this.isKwar3,
    this.isRas,
    this.isLyh,
    this.isKarashah,
    this.productId,
    this.createdAt,
    this.updatedAt,
    this.shalwata,
    this.preparation,
    this.size,
    this.cut,
    this.product,
  });

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    totalPrice = json['total_price'];
    orderRefNo = json['order_ref_no'];
    isKwar3 = json['is_kwar3'];
    isRas = json['is_Ras'];
    isLyh = json['is_lyh'];
    isKarashah = json['is_karashah'];
    productId = json['product_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    preparation = json['preparation'] != null
        ? Extra.fromJson(json['preparation'])
        : null;
    shalwata = json['shalwata'] != null
        ? Extra.fromJson(json['shalwata'])
        : null;
    size = json['size'] != null ? Extra.fromJson(json['size']) : null;
    cut = json['cut'] != null ? Extra.fromJson(json['cut']) : null;
    product = json['product'] != null
        ? Product.fromJson(json['product'])
        : null;
  }
}

class Extra {
  int? id;
  String? nameAr;
  String? nameEn;

  Extra({this.id, this.nameAr, this.nameEn});

  Extra.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
  }
}

class Product {
  int? id;
  String? nameAr;
  String? nameEn;
  String? descriptionAr;
  String? descriptionEn;
  String? price;
  String? salePrice;
  bool? isKwar3;
  bool? isRas;
  bool? isLyh;
  bool? isKarashah;
  bool? isShalwata;
  List<ProductImages>? productImages;
  int? categoryId;
  Product({
    this.id,
    this.nameAr,
    this.nameEn,
    this.categoryId,
    this.descriptionAr,
    this.descriptionEn,
    this.price,
    this.salePrice,
    this.isKwar3,
    this.isRas,
    this.isLyh,
    this.isKarashah,
    this.isShalwata,
    this.productImages,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    descriptionAr = json['description_ar'];
    descriptionEn = json['description_en'];
    price = json['price'];
    salePrice = json['sale_price'];
    isKwar3 = json['is_kwar3'];
    isRas = json['is_Ras'];
    isLyh = json['is_lyh'];
    isKarashah = json['is_karashah'];
    isShalwata = json['is_shalwata'];
    categoryId = json['category_id'];
    if (json['product_images'] != null) {
      productImages = <ProductImages>[];
      json['product_images'].forEach((v) {
        productImages!.add(ProductImages.fromJson(v));
      });
    }
  }
}

class ProductImages {
  int? id;
  int? productId;
  int? isDefault;
  String? imageUrl;
  String? thumbnailUrl;

  ProductImages({this.imageUrl});

  ProductImages.fromJson(Map<String, dynamic> json) {
    imageUrl = json['image_url'];
  }
}
