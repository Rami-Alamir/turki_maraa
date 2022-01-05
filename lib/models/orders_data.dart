class OrdersData {
  bool? success;
  List<Data>? data;
  String? message;
  String? description;
  String? code;

  OrdersData(
      {this.success, this.data, this.message, this.description, this.code});

  OrdersData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
    description = json['description'];
    code = json['code'];
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
  OrderState? orderState;
  List<Products>? products;

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
      this.orderState,
      this.products});

  Data.fromJson(Map<String, dynamic> json) {
    refNo = json['ref_no'];
    deliveryFee = json['delivery_fee'];
    orderTotal = json['order_total'];
    totalAmount = json['total_amount'];
    totalAmountAfterDiscount = json['total_amount_after_discount'];
    comment = json['comment'];
    usingWallet = json['using_wallet'];
    walletAmountUsed = json['wallet_amount_used'];
    appliedDiscountCode = json['applied_discount_code'];
    address = json['address'];
    addressId = json['address_id'];
    customerId = json['customer_id'];
    orderStateId = json['order_state_id'];
    paymentTypeId = json['payment_type_id'];
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

class Products {
  int? id;
  String? nameAr;
  String? nameEn;
  String? description;
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

  Products(
      {this.id,
      this.nameAr,
      this.nameEn,
      this.description,
      this.weight,
      this.calories,
      this.noRating,
      this.price,
      this.salePrice,
      this.isActive,
      this.isShalwata,
      this.isDelivered,
      this.isPickedUp,
      this.categoryId,
      this.subCategoryId});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    description = json['description'];
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_ar'] = this.nameAr;
    data['name_en'] = this.nameEn;
    data['description'] = this.description;
    data['weight'] = this.weight;
    data['calories'] = this.calories;
    data['no_rating'] = this.noRating;
    data['price'] = this.price;
    data['sale_price'] = this.salePrice;
    data['is_active'] = this.isActive;
    data['is_shalwata'] = this.isShalwata;
    data['is_delivered'] = this.isDelivered;
    data['is_picked_up'] = this.isPickedUp;
    data['category_id'] = this.categoryId;
    data['sub_category_id'] = this.subCategoryId;
    return data;
  }
}
