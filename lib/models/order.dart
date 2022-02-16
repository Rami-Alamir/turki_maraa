class Order {
  List<Data>? data;

  Order({this.data});

  Order.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }
}

class Data {
  String? refNo;
  String? deliveryFee;
  String? orderTotal;
  String? totalAmount;
  String? totalAmountAfterDiscount;
  String? comment;
  int? usingWallet;
  String? walletAmountUsed;
  String? appliedDiscountCode;
  String? address;
  int? addressId;
  int? customerId;
  int? orderStateId;
  int? paymentTypeId;
  String? createdAt;
  String? updatedAt;
  List<Products>? products;
  OrderState? orderState;
  DeliveryPeriod? deliveryPeriod;
  String? deliveryDate;

  Data(
      {this.refNo,
      this.deliveryFee,
      this.orderTotal,
      this.totalAmount,
      this.totalAmountAfterDiscount,
      this.comment,
      this.usingWallet,
      this.walletAmountUsed,
      this.appliedDiscountCode,
      this.address,
      this.addressId,
      this.customerId,
      this.orderStateId,
      this.paymentTypeId,
      this.createdAt,
      this.updatedAt,
      this.products,
      this.orderState,
      this.deliveryPeriod,
      this.deliveryDate});

  Data.fromJson(Map<String, dynamic> json) {
    refNo = json['ref_no'];
    deliveryFee = json['delivery_fee'];
    orderTotal = json['order_subtotal'];
    totalAmount = json['total_amount'];
    totalAmountAfterDiscount = json['total_amount_after_discount'];
    comment = json['comment'];
    usingWallet = json['using_wallet'];
    walletAmountUsed = json['wallet_amount_used'];
    appliedDiscountCode = json['applied_discount_code'] ?? "";
    address = json['address'];
    addressId = json['address_id'];
    customerId = json['customer_id'];
    orderStateId = json['order_state_id'];
    paymentTypeId = json['payment_type_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
      deliveryPeriod = json['delivery_period'] != null
          ? DeliveryPeriod.fromJson(json['delivery_period'])
          : null;
      deliveryDate = json['delivery_date'] ?? "";
    }
    orderState = json['order_state'] != null
        ? OrderState.fromJson(json['order_state'])
        : null;
  }
}

class DeliveryPeriod {
  int? id;
  String? nameAr;
  String? nameEn;
  int? isActive;
  String? timeHhmm;
  String? createdAt;
  String? updatedAt;

  DeliveryPeriod(
      {this.id,
      this.nameAr,
      this.nameEn,
      this.isActive,
      this.timeHhmm,
      this.createdAt,
      this.updatedAt});

  DeliveryPeriod.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    isActive = json['is_active'];
    timeHhmm = json['time_hhmm'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

class Products {
  int? id;
  String? nameAr;
  String? nameEn;
  String? descriptionAr;
  String? descriptionEn;
  String? weight;
  String? calories;
  int? noRating;
  String? price;
  String? salePrice;
  bool? isActive;
  bool? isShalwata;
  int? isDelivered;
  int? isPickedUp;
  int? categoryId;
  int? subCategoryId;
  List<ProductImages>? productImages;

  Products(
      {this.id,
      this.nameAr,
      this.nameEn,
      this.descriptionAr,
      this.descriptionEn,
      this.weight,
      this.calories,
      this.noRating,
      this.price,
      this.salePrice,
      this.isActive,
      this.isShalwata,
      this.productImages,
      this.isDelivered,
      this.isPickedUp,
      this.categoryId,
      this.subCategoryId});

  Products.fromJson(Map<String, dynamic> json) {
    if (json['product_images'] != null) {
      productImages = <ProductImages>[];
      json['product_images'].forEach((v) {
        productImages!.add(ProductImages.fromJson(v));
      });
    }
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    descriptionAr = json['description_ar'];
    descriptionEn = json['description_en'];
    weight = json['weight'];
    calories = json['calories'];
    noRating = json['no_rating'];
    price = json['price'];
    salePrice = json['sale_price'];
    isActive = json['is_active'];
    isShalwata = json['is_shalwata'];
    isDelivered = json['is_delivered'];
    isPickedUp = json['is_picked_up'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
  }
}

class OrderState {
  int? code;
  String? stateEn;
  String? stateAr;
  String? customerStateEn;
  String? customerStateAr;
  int? isActive;
  String? createdAt;
  String? updatedAt;

  OrderState(
      {this.code,
      this.stateEn,
      this.stateAr,
      this.customerStateEn,
      this.customerStateAr,
      this.isActive,
      this.createdAt,
      this.updatedAt});

  OrderState.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    stateEn = json['state_en'];
    stateAr = json['state_ar'];
    customerStateEn = json['customer_state_en'];
    customerStateAr = json['customer_state_ar'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

class ProductImages {
  int? id;
  int? productId;
  int? isDefault;
  String? createdAt;
  String? updatedAt;
  String? imageUrl;
  String? thumbnailUrl;

  ProductImages(
      {this.id,
      this.productId,
      this.isDefault,
      this.createdAt,
      this.updatedAt,
      this.imageUrl,
      this.thumbnailUrl});

  ProductImages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    isDefault = json['is_default'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    imageUrl = json['image_url'];
    thumbnailUrl = json['thumbnail_url'];
  }
}
