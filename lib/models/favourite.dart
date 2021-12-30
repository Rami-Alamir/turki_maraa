class Favourite {
  DataT? dataT;
  String? message;
  String? description;
  String? code;

  Favourite({this.dataT, this.message, this.description, this.code});

  Favourite.fromJson(Map<String, dynamic> json) {
    dataT = json['data'] != null ? new DataT.fromJson(json['data']) : null;
    message = json['message'];
    description = json['description'];
    code = json['code'];
  }
}

class DataT {
  List<Data>? data;

  DataT({this.data});

  DataT.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }
}

class Data {
  Product? product;

  Data({this.product});

  Data.fromJson(Map<String, dynamic> json) {
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
  }
}

class Product {
  int? id;
  String? nameAr;
  String? nameEn;
  String? description;
  String? weight;
  String? calories;
  int? noRating;
  String? image;
  String? price;
  String? salePrice;
  bool? isActive;
  bool? isShalwata;
  int? isDelivered;
  int? isPickedUp;
  int? categoryId;
  int? subCategoryId;

  Product(
      {this.id,
      this.nameAr,
      this.nameEn,
      this.description,
      this.weight,
      this.calories,
      this.noRating,
      this.image,
      this.price,
      this.salePrice,
      this.isActive,
      this.isShalwata,
      this.isDelivered,
      this.isPickedUp,
      this.categoryId,
      this.subCategoryId});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'] ?? "";
    nameEn = json['name_en'] ?? "";
    description = json['description'] ?? "";
    weight = json['weight'] ?? "";
    calories = json['calories'] ?? "";
    noRating = json['no_rating'] ?? "";
    image = json['image'] ??
        "https://turki.turkieshop.com/images/Jk78x2iKpI1608014433.png?431112";
    price = json['price'] ?? "";
    salePrice = json['sale_price'] ?? "";
    isActive = json['is_active'] ?? "";
    isShalwata = json['is_shalwata'] ?? "";
    isDelivered = json['is_delivered'] ?? "";
    isPickedUp = json['is_picked_up'] ?? "";
    categoryId = json['category_id'] ?? "";
    subCategoryId = json['sub_category_id'] ?? "";
  }
}
