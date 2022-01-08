class Product {
  Data? data;

  Product({this.data});

  Product.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? id;
  String? nameAr;
  String? nameEn;
  String? price;
  String? weight;
  String? calories;
  int? noRating;
  Category? category;
  SubCategory? subCategory;
  int? isPickedUp;
  int? isDelivered;
  bool? isShalwata;
  Extra? shalwata;
  bool? isActive;
  List<PaymentTypes>? paymentTypes;
  List<Images>? images;
  List<Extra>? sizes;
  List<Extra>? packaging;
  List<Extra>? chopping;

  Data(
      {this.id,
      this.nameAr,
      this.nameEn,
      this.price,
      this.weight,
      this.calories,
      this.noRating,
      this.category,
      this.subCategory,
      this.isPickedUp,
      this.isDelivered,
      this.isShalwata,
      this.shalwata,
      this.isActive,
      this.images,
      this.sizes,
      this.packaging,
      this.chopping});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    nameAr = json['name_ar'] ?? '';
    nameEn = json['name_en'] ?? '';
    price = json['price'] ?? '';
    weight = json['weight'] ?? '';
    calories = json['calories'] ?? '';
    noRating = json['no_rating'] ?? 5;
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    subCategory = json['sub_category'] != null
        ? new SubCategory.fromJson(json['sub_category'])
        : null;
    isPickedUp = json['is_picked_up'] ?? 0;
    isDelivered = json['is_delivered'] ?? 0;
    isShalwata = json['is_shalwata'] ?? false;
    shalwata =
        json['shalwata'] != null ? new Extra.fromJson(json['shalwata']) : null;
    isActive = json['is_active'] ?? 1;

    if (json['payment_types'] != null) {
      paymentTypes = <PaymentTypes>[];
      json['payment_types'].forEach((v) {
        paymentTypes!.add(PaymentTypes.fromJson(v));
      });
    }
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
    if (json['sizes'] != null) {
      sizes = <Extra>[];
      json['sizes'].forEach((v) {
        sizes!.add(Extra.fromJson(v));
      });
    }
    if (json['cuts'] != null) {
      chopping = <Extra>[];
      json['cuts'].forEach((v) {
        chopping!.add(Extra.fromJson(v));
      });
    }
    if (json['preparations'] != null) {
      packaging = <Extra>[];
      json['preparations'].forEach((v) {
        packaging!.add(Extra.fromJson(v));
      });
    }
  }
}

class Extra {
  int? id;
  String? nameAr;
  String? nameEn;
  String? price;
  Extra({
    this.id,
    this.nameAr,
    this.nameEn,
    this.price,
  });
  factory Extra.fromJson(Map<String, dynamic> json) => Extra(
        id: json["id"] ?? 0,
        nameAr: json["name_ar"] ?? "",
        nameEn: json["name_en"] ?? "",
        price: json["price"] ?? "",
      );
}

class Category {
  int? id;
  String? typeAr;
  String? typeEn;
  String? description;
  String? imageUrl;
  String? thumbnailUrl;

  Category(
      {this.id,
      this.typeAr,
      this.typeEn,
      this.description,
      this.imageUrl,
      this.thumbnailUrl});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    typeAr = json['type_ar'] ?? "";
    typeEn = json['type_en'] ?? "";
    description = json['description'] ?? "";
    imageUrl = json['image_url'] ?? "";
    thumbnailUrl = json['thumbnail_url'] ?? "";
  }
}

class SubCategory {
  int? id;
  int? categoryId;
  String? typeAr;
  String? typeEn;
  String? description;
  String? imageUrl;
  String? thumbnailUrl;

  SubCategory(
      {this.id,
      this.categoryId,
      this.typeAr,
      this.typeEn,
      this.description,
      this.imageUrl,
      this.thumbnailUrl});

  SubCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    typeAr = json['type_ar'] ?? "";
    typeEn = json['type_en'] ?? "";
    description = json['description'] ?? "";
    imageUrl = json['image_url'] ?? "";
    thumbnailUrl = json['thumbnail_url'] ?? "";
  }
}

class Shalwata {
  int? id;
  String? nameAr;
  String? nameEn;
  String? price;

  Shalwata({this.id, this.nameAr, this.nameEn, this.price});

  Shalwata.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    nameAr = json['name_ar'] ?? "";
    nameEn = json['name_en'] ?? "";
    price = json['price'] ?? "";
  }
}

class PaymentTypes {
  int? id;
  String? nameAr;
  String? nameEn;
  String? code;
  String? createdAt;
  String? updatedAt;
  PaymentTypesPivot? pivot;

  PaymentTypes(
      {this.id,
      this.nameAr,
      this.nameEn,
      this.code,
      this.createdAt,
      this.updatedAt,
      this.pivot});

  PaymentTypes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'] ?? "";
    nameEn = json['name_en'] ?? "";
    code = json['code'] ?? "";
    createdAt = json['created_at'] ?? "";
    updatedAt = json['updated_at'] ?? "";
    pivot = json['pivot'] != null
        ? PaymentTypesPivot.fromJson(json['pivot'])
        : null;
  }
}

class PaymentTypesPivot {
  int? productId;
  int? paymentTypeId;
  PaymentTypesPivot({this.productId, this.paymentTypeId});
  PaymentTypesPivot.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'] ?? 0;
    paymentTypeId = json['payment_type_id'] ?? 0;
  }
}

class Images {
  int? id;
  int? productId;
  int? isDefault;
  String? imageUrl;
  String? thumbnailUrl;

  Images(
      {this.id,
      this.productId,
      this.isDefault,
      this.imageUrl,
      this.thumbnailUrl});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    productId = json['product_id'] ?? 0;
    isDefault = json['is_default'] ?? 0;
    imageUrl = json['image_url'] ?? '';
    thumbnailUrl = json['thumbnail_url'] ?? "";
  }
}
