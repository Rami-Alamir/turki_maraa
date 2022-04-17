class Order {
  Data? data;
  Order({this.data});

  Order.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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
  String? appliedDiscountCode;
  String? discountApplied;
  String? address;
  int? addressId;
  int? shalwataId;
  int? customerId;
  int? orderStateId;
  int? paymentTypeId;
  int? deliveryPeriodId;
  String? deliveryDate;
  int? paymentId;
  String? createdAt;
  String? updatedAt;
  List<Products>? products;
  OrderState? orderState;
  DeliveryPeriod? deliveryPeriod;
  List<OrderProducts>? orderProducts;
  SelectedAddress? selectedAddress;

  Data(
      {this.refNo,
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
      this.addressId,
      this.shalwataId,
      this.customerId,
      this.orderStateId,
      this.paymentTypeId,
      this.deliveryPeriodId,
      this.deliveryDate,
      this.paymentId,
      this.createdAt,
      this.orderProducts,
      this.updatedAt,
      this.products,
      this.orderState,
      this.deliveryPeriod,
      this.selectedAddress});

  Data.fromJson(Map<String, dynamic> json) {
    selectedAddress = json['selected_address'] != null
        ? new SelectedAddress.fromJson(json['selected_address'])
        : null;
    refNo = json['ref_no'];
    deliveryFee = json['delivery_fee'] ?? "";
    orderSubtotal = json['order_subtotal'] ?? "";
    totalAmount = json['total_amount'] ?? "";
    totalAmountAfterDiscount = json['total_amount_after_discount'] ?? "";
    comment = json['comment'] ?? "";
    usingWallet = json['using_wallet'] ?? 0;
    walletAmountUsed = json['wallet_amount_used'] ?? "";
    appliedDiscountCode = json['applied_discount_code'] ?? "";
    discountApplied = json['discount_applied'] ?? "";
    address = json['address'] ?? "";
    addressId = json['address_id'];
    shalwataId = json['shalwata_id'];
    customerId = json['customer_id'];
    orderStateId = json['order_state_id'];
    paymentTypeId = json['payment_type_id'];
    deliveryPeriodId = json['delivery_period_id'];
    deliveryDate = json['delivery_date'];
    paymentId = json['payment_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
    if (json['order_products'] != null) {
      orderProducts = <OrderProducts>[];
      json['order_products'].forEach((v) {
        orderProducts!.add(new OrderProducts.fromJson(v));
      });
    }
    orderState = json['order_state'] != null
        ? new OrderState.fromJson(json['order_state'])
        : null;
    deliveryPeriod = json['delivery_period'] != null
        ? new DeliveryPeriod.fromJson(json['delivery_period'])
        : null;
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
  int? subCategoryId;
  List<ProductImages>? productImages;

  Products({
    this.id,
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
    this.subCategoryId,
    this.productImages,
  });

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
    subCategoryId = json['sub_category_id'];
    if (json['product_images'] != null) {
      productImages = <ProductImages>[];
      json['product_images'].forEach((v) {
        productImages!.add(new ProductImages.fromJson(v));
      });
    }
  }
}

class ProductImages {
  int? id;
  int? productId;
  int? isDefault;
  String? imageUrl;

  ProductImages({
    this.id,
    this.productId,
    this.isDefault,
    this.imageUrl,
  });

  ProductImages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    isDefault = json['is_default'];
    imageUrl = json['image_url'];
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

class DeliveryPeriod {
  int? id;
  String? nameAr;
  String? nameEn;
  int? isActive;
  String? createdAt;
  String? updatedAt;

  DeliveryPeriod(
      {this.id,
      this.nameAr,
      this.nameEn,
      this.isActive,
      this.createdAt,
      this.updatedAt});

  DeliveryPeriod.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

class OrderProducts {
  int? id;
  int? quantity;
  String? totalPrice;
  Preparation? preparation;
  Size? size;
  Preparation? cut;
  Shalwata? shalwata;
  Product? product;
  bool? isKwar3;
  bool? isRas;
  bool? isLyh;
  bool? isKarashah;
  OrderProducts(
      {this.id,
      this.quantity,
      this.totalPrice,
      this.preparation,
      this.size,
      this.cut,
      this.isKwar3,
      this.isRas,
      this.isKarashah,
      this.isLyh,
      this.shalwata,
      this.product});

  OrderProducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isKwar3 = json['is_kwar3'] ?? false;
    isRas = json['is_Ras'] ?? false;
    isLyh = json['is_lyh'] ?? false;
    isKarashah = json['is_karashah'] ?? false;
    quantity = json['quantity'];
    totalPrice = json['total_price'];
    preparation = json['preparation'] != null
        ? new Preparation.fromJson(json['preparation'])
        : null;
    size = json['size'] != null ? new Size.fromJson(json['size']) : null;
    cut = json['cut'] != null ? new Preparation.fromJson(json['cut']) : null;
    shalwata = json['shalwata'] != null
        ? new Shalwata.fromJson(json['shalwata'])
        : null;
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
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
  List<ProductImages>? productImages;

  Product(
      {this.id,
      this.nameAr,
      this.nameEn,
      this.descriptionAr,
      this.descriptionEn,
      this.price,
      this.salePrice,
      this.productImages});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];

    descriptionAr = json['description_ar'];
    descriptionEn = json['description_en'];
    price = json['price'];
    salePrice = json['sale_price'];
    if (json['product_images'] != null) {
      productImages = <ProductImages>[];
      json['product_images'].forEach((v) {
        productImages!.add(new ProductImages.fromJson(v));
      });
    }
  }
}

class Preparation {
  String? nameAr;
  String? nameEn;

  Preparation({this.nameAr, this.nameEn});

  Preparation.fromJson(Map<String, dynamic> json) {
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
  }
}

class Size {
  String? nameAr;
  String? nameEn;

  Size({
    this.nameAr,
    this.nameEn,
  });

  Size.fromJson(Map<String, dynamic> json) {
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
  }
}

class Shalwata {
  String? nameAr;
  String? nameEn;

  Shalwata({this.nameAr, this.nameEn});

  Shalwata.fromJson(Map<String, dynamic> json) {
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
  }
}

class SelectedAddress {
  int? id;
  String? address;
  String? comment;
  String? label;
  String? long;
  String? lat;

  SelectedAddress(
      {this.id, this.address, this.comment, this.label, this.long, this.lat});

  SelectedAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    address = json['address'] ?? "";
    comment = json['comment'];
    label = json['label'];
    long = json['long'];
    lat = json['lat'];
  }
}
