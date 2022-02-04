class OrdersData {
  List<Data>? data;

  OrdersData({this.data});

  OrdersData.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }
}

class Data {
  String? refNo;
  String? deliveryFee;
  String? orderSubtotal;
  String? totalAmount;
  String? totalAmountAfterDiscount;
  String? comment;
  int? usingWallet;
  String? walletAmountUsed;
  String? discountApplied;
  String? address;
  int? addressId;
  int? shalwataId;
  int? customerId;
  int? orderStateId;
  int? paymentTypeId;
  int? deliveryPeriodId;
  int? deliveryDateId;
  String? createdAt;
  String? updatedAt;
  OrderState? orderState;
  List<Products>? products;
  DeliveryPeriod? deliveryPeriod;
  DeliveryDate? deliveryDate;

  Data(
      {this.refNo,
      this.deliveryFee,
      this.orderSubtotal,
      this.totalAmount,
      this.totalAmountAfterDiscount,
      this.comment,
      this.usingWallet,
      this.walletAmountUsed,
      this.discountApplied,
      this.address,
      this.addressId,
      this.shalwataId,
      this.customerId,
      this.orderStateId,
      this.paymentTypeId,
      this.deliveryPeriodId,
      this.deliveryDateId,
      this.createdAt,
      this.updatedAt,
      this.orderState,
      this.products,
      this.deliveryPeriod,
      this.deliveryDate});

  Data.fromJson(Map<String, dynamic> json) {
    refNo = json['ref_no'];
    deliveryFee = json['delivery_fee'];
    orderSubtotal = json['order_subtotal'];
    totalAmount = json['total_amount'];
    totalAmountAfterDiscount = json['total_amount_after_discount'];
    comment = json['comment'];
    usingWallet = json['using_wallet'];
    walletAmountUsed = json['wallet_amount_used'];
    discountApplied = json['discount_applied'];
    address = json['address'];
    addressId = json['address_id'];
    shalwataId = json['shalwata_id'];
    customerId = json['customer_id'];
    orderStateId = json['order_state_id'];
    paymentTypeId = json['payment_type_id'];
    deliveryPeriodId = json['delivery_period_id'];
    deliveryDateId = json['delivery_date_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    orderState = json['order_state'] != null
        ? new OrderState.fromJson(json['order_state'])
        : null;
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
    deliveryPeriod = json['delivery_period'] != null
        ? new DeliveryPeriod.fromJson(json['delivery_period'])
        : null;
    deliveryDate = json['delivery_date'] != null
        ? new DeliveryDate.fromJson(json['delivery_date'])
        : null;
  }
}

class OrderState {
  int? code;
  String? stateEn;
  String? stateAr;
  String? customerStateEn;
  String? customerStateAr;
  int? isActive;

  OrderState({
    this.code,
    this.stateEn,
    this.stateAr,
    this.customerStateEn,
    this.customerStateAr,
    this.isActive,
  });

  OrderState.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    stateEn = json['state_en'];
    stateAr = json['state_ar'];
    customerStateEn = json['customer_state_en'];
    customerStateAr = json['customer_state_ar'];
    isActive = json['is_active'];
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
  int? noSale;
  String? price;
  String? salePrice;
  bool? isActive;
  bool? isShalwata;
  int? isDelivered;
  int? isPickedUp;
  int? categoryId;
  Null? shalwataId;
  int? subCategoryId;
  List<ProductImages>? productImages;
  Null? shalwata;

  Products(
      {this.id,
      this.nameAr,
      this.nameEn,
      this.descriptionAr,
      this.descriptionEn,
      this.weight,
      this.calories,
      this.noRating,
      this.noSale,
      this.price,
      this.salePrice,
      this.isActive,
      this.isShalwata,
      this.isDelivered,
      this.isPickedUp,
      this.categoryId,
      this.shalwataId,
      this.subCategoryId,
      this.productImages,
      this.shalwata});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    descriptionAr = json['description_ar'];
    descriptionEn = json['description_en'];
    weight = json['weight'];
    calories = json['calories'];
    noRating = json['no_rating'];
    noSale = json['no_sale'];
    price = json['price'];
    salePrice = json['sale_price'];
    isActive = json['is_active'];
    isShalwata = json['is_shalwata'];
    isDelivered = json['is_delivered'];
    isPickedUp = json['is_picked_up'];
    categoryId = json['category_id'];
    shalwataId = json['shalwata_id'];
    subCategoryId = json['sub_category_id'];
    if (json['product_images'] != null) {
      productImages = <ProductImages>[];
      json['product_images'].forEach((v) {
        productImages!.add(new ProductImages.fromJson(v));
      });
    }
    shalwata = json['shalwata'];
  }
}

class ProductImages {
  int? id;
  int? productId;
  int? isDefault;

  String? imageUrl;
  String? thumbnailUrl;

  ProductImages(
      {this.id,
      this.productId,
      this.isDefault,
      this.imageUrl,
      this.thumbnailUrl});

  ProductImages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    isDefault = json['is_default'];

    imageUrl = json['image_url'];
    thumbnailUrl = json['thumbnail_url'];
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

class DeliveryDate {
  int? id;
  int? cityId;
  String? dateYyyymmdd;
  int? isActive;
  String? createdAt;
  String? updatedAt;

  DeliveryDate(
      {this.id,
      this.cityId,
      this.dateYyyymmdd,
      this.isActive,
      this.createdAt,
      this.updatedAt});

  DeliveryDate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cityId = json['city_id'];
    dateYyyymmdd = json['date_yyyymmdd'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
