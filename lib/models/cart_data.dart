class CartData {
  Data? data;
  CartData({this.data});
  CartData.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  Cart? cart;
  List<MinOrder>? minOrder;

  InvoicePreview? invoicePreview;
  Data({this.cart, this.invoicePreview, this.minOrder});
  Data.fromJson(Map<String, dynamic> json) {
    cart = json['cart'] != null ? new Cart.fromJson(json['cart']) : null;
    if (json['min_order'] != null) {
      minOrder = <MinOrder>[];
      json['min_order'].forEach((v) {
        minOrder!.add(MinOrder.fromJson(v));
      });
    }
    invoicePreview = json['invoice-preview'] != null
        ? new InvoicePreview.fromJson(json['invoice-preview'])
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
  int? shalwataId;
  int? preparationId;
  int? sizeId;
  int? cutId;
  int? isShalwata;
  int? productId;
  int? quantity;
  int? customerId;
  Product? product;
  Shalwata? preparation;
  Size? size;
  Shalwata? cut;
  Shalwata? shalwata;

  ItemData(
      {this.id,
      this.comment,
      this.appliedDiscountCode,
      this.shalwataId,
      this.preparationId,
      this.sizeId,
      this.cutId,
      this.isShalwata,
      this.productId,
      this.quantity,
      this.customerId,
      this.product,
      this.preparation,
      this.size,
      this.cut,
      this.shalwata});

  ItemData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comment = json['comment'];
    appliedDiscountCode = json['applied_discount_code'];
    shalwataId = json['shalwata_id'] ?? 0;
    preparationId = json['preparation_id'];
    sizeId = json['size_id'];
    cutId = json['cut_id'];
    isShalwata = json['is_shalwata'];
    productId = json['product_id'];
    quantity = json['quantity'];
    customerId = json['customer_id'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
    preparation = json['preparation'] != null
        ? new Shalwata.fromJson(json['preparation'])
        : null;
    size = json['size'] != null ? Size.fromJson(json['size']) : null;
    cut = json['cut'] != null ? Shalwata.fromJson(json['cut']) : null;
    shalwata = json['shalwata'] != null
        ? new Shalwata.fromJson(json['shalwata'])
        : null;
  }
}

class Product {
  int? id;
  String? nameAr;
  String? nameEn;
  String? descriptionAr;
  String? descriptionEn;
  String? weight;
  String? calories;
  int? noRating;
  int? noSale;
  int? noClicked;
  String? price;
  String? salePrice;
  bool? isActive;
  bool? isShalwata;
  int? isDelivered;
  int? isPickedUp;
  int? categoryId;
  int? shalwataId;
  int? subCategoryId;
  List<ProductImages>? productImages;
  Shalwata? shalwata;
  List<ProductPaymentTypes>? productPaymentTypes;

  Product(
      {this.id,
      this.nameAr,
      this.nameEn,
      this.descriptionAr,
      this.descriptionEn,
      this.weight,
      this.calories,
      this.noRating,
      this.noSale,
      this.noClicked,
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
      this.shalwata,
      this.productPaymentTypes});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    descriptionAr = json['description_ar'];
    descriptionEn = json['description_en'];
    weight = json['weight'];
    calories = json['calories'];
    noRating = json['no_rating'];
    noSale = json['no_sale'];
    noClicked = json['no_clicked'];
    price = json['price'];
    salePrice = json['sale_price'] ?? "0";
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
    shalwata = json['shalwata'] != null
        ? new Shalwata.fromJson(json['shalwata'])
        : null;
    if (json['product_payment_types'] != null) {
      productPaymentTypes = <ProductPaymentTypes>[];
      json['product_payment_types'].forEach((v) {
        productPaymentTypes!.add(new ProductPaymentTypes.fromJson(v));
      });
    }
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

class Shalwata {
  int? id;
  String? nameAr;
  String? nameEn;
  String? price;

  Shalwata({this.id, this.nameAr, this.nameEn, this.price});

  Shalwata.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_ar'] = this.nameAr;
    data['name_en'] = this.nameEn;
    data['price'] = this.price;
    return data;
  }
}

class ProductPaymentTypes {
  int? id;
  String? nameAr;
  String? nameEn;
  String? code;

  ProductPaymentTypes({this.id, this.nameAr, this.nameEn, this.code});

  ProductPaymentTypes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_ar'] = this.nameAr;
    data['name_en'] = this.nameEn;
    data['code'] = this.code;
    return data;
  }
}

class Size {
  int? id;
  String? nameAr;
  String? nameEn;
  String? price;
  String? salePrice;

  Size({this.id, this.nameAr, this.nameEn, this.price, this.salePrice});

  Size.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    price = json['price'];
    salePrice = json['sale_price'] ?? "0";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_ar'] = this.nameAr;
    data['name_en'] = this.nameEn;
    data['price'] = this.price;
    data['sale_price'] = this.salePrice;
    return data;
  }
}

class MinOrder {
  int? id;
  int? countryId;
  String? minOrder;

  MinOrder({this.id, this.countryId, this.minOrder});

  MinOrder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    countryId = json['country_id'];
    minOrder = json['min_order'];
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['label'] = this.label;
    data['active'] = this.active;
    return data;
  }
}

class InvoicePreview {
  double? deliveryFee;
  double? orderSubtotal;
  double? totalAmount;
  double? discountApplied;
  double? totalAmountAfterDiscount;
  String? appliedDiscountCode;
  int? usingWallet;
  double? walletAmountUsed;

  InvoicePreview(
      {this.deliveryFee,
      this.orderSubtotal,
      this.totalAmount,
      this.totalAmountAfterDiscount,
      this.appliedDiscountCode,
      this.usingWallet,
      this.walletAmountUsed});

  InvoicePreview.fromJson(Map<String, dynamic> json) {
    deliveryFee = (json['delivery_fee'] ?? 0) * 1.0;
    discountApplied = (json['discount_applied'] ?? 0.0) * 1.0;
    orderSubtotal = (json['order_subtotal'] ?? 0) * 1.0;
    totalAmount = (json['total_amount'] ?? 0) * 1.0;
    totalAmountAfterDiscount = (json['total_amount_after_discount'] ?? 0) * 1.0;
    appliedDiscountCode = json['applied_discount_code'];
    usingWallet = json['using_wallet'];
    walletAmountUsed = (json['wallet_amount_used'] ?? 0) * 1.0;
  }
}
