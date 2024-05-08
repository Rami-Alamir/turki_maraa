class OrdersData {
  OrderData? orderData;
  OrdersData({this.orderData});

  OrdersData.fromJson(Map<String, dynamic> json) {
    orderData = json['data'] != null ? OrderData.fromJson(json['data']) : null;
  }
}

class OrderData {
  List<Data>? data;

  OrderData({
    this.data,
  });

  OrderData.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }
}

class Data {
  int? id;
  String? refNo;
  String? deliveryFee;
  String? orderSubtotal;
  String? totalAmount;
  String? totalAmountAfterDiscount;
  String? comment;
  int? usingWallet;
  String? walletAmountUsed;
  String? appliedDiscountCode;
  String? discountApplied;
  String? address;
  int? shalwataId;
  int? paymentTypeId;
  int? orderStateId;
  String? deliveryDate;
  String? createdAt;
  String? updatedAt;
  String? orderStateAr;
  String? orderStateEn;
  String? paymentTypeName;
  String? deliveryPeriodName;
  String? deliveryPeriodTime;
  String? paymentPrice;
  String? paymentStatus;
  String? addressAddress;
  List<OrderProducts>? orderProducts;

  Data({
    this.id,
    this.refNo,
    this.deliveryFee,
    this.orderSubtotal,
    this.totalAmount,
    this.totalAmountAfterDiscount,
    this.comment,
    this.usingWallet,
    this.walletAmountUsed,
    this.appliedDiscountCode,
    this.discountApplied,
    this.address,
    this.shalwataId,
    this.orderStateId,
    this.deliveryDate,
    this.createdAt,
    this.updatedAt,
    this.orderStateAr,
    this.orderStateEn,
    this.paymentTypeName,
    this.deliveryPeriodName,
    this.deliveryPeriodTime,
    this.paymentPrice,
    this.paymentStatus,
    this.paymentTypeId,
    this.addressAddress,
    this.orderProducts,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    refNo = json['ref_no'];
    deliveryFee = json['delivery_fee'];
    orderSubtotal = json['order_subtotal'];
    totalAmount = json['total_amount'];
    totalAmountAfterDiscount = json['total_amount_after_discount'];
    comment = json['comment'];
    usingWallet = json['using_wallet'];
    walletAmountUsed = json['wallet_amount_used'];
    appliedDiscountCode = json['applied_discount_code'];
    discountApplied = json['discount_applied'];
    address = json['address'];
    shalwataId = json['shalwata_id'];
    orderStateId = json['order_state_id'];
    deliveryDate = json['delivery_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    orderStateAr = json['order_state_ar'];
    orderStateEn = json['order_state_en'];
    paymentTypeName = json['payment_type_name'];
    deliveryPeriodName = json['delivery_period_name'];
    deliveryPeriodTime = json['delivery_period_time'];
    paymentPrice = json['payment_price'].toString();
    paymentStatus = json['payment_status'];
    addressAddress = json['address_address'];
    paymentTypeId = json['payment_type_id'];
    if (json['orderProducts'] != null) {
      orderProducts = <OrderProducts>[];
      json['orderProducts'].forEach((v) {
        orderProducts!.add(OrderProducts.fromJson(v));
      });
    }
  }
}

class OrderProducts {
  int? id;
  Product? product;

  OrderProducts({this.id, this.product});

  OrderProducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
  }
}

class Product {
  List<ProductImages>? productImages;

  Product({this.productImages});

  Product.fromJson(Map<String, dynamic> json) {
    if (json['product_images'] != null) {
      productImages = <ProductImages>[];
      json['product_images'].forEach((v) {
        productImages!.add(ProductImages.fromJson(v));
      });
    }
  }
}

class ProductImages {
  String? imageUrl;

  ProductImages({
    this.imageUrl,
  });

  ProductImages.fromJson(Map<String, dynamic> json) {
    imageUrl = json['image_url'];
  }
}
