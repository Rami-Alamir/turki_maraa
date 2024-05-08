import 'category.dart';
import 'extra.dart';
import 'images.dart';

class Product {
  List<Data>? data;

  Product({this.data});

  Product.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }
}

class Data {
  String? typeAr;
  String? typeEn;
  String? imageUrl;
  Category? category;
  List<ProductData>? products;

  Data({this.typeAr, this.typeEn, this.imageUrl, this.category, this.products});

  Data.fromJson(Map<String, dynamic> json) {
    typeAr = json['type_ar'] ?? "";
    typeEn = json['type_en'] ?? "";
    imageUrl = json['image_url'] ?? "";
    category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
    if (json['products'] != null) {
      products = <ProductData>[];
      json['products'].forEach((v) {
        products!.add(ProductData.fromJson(v));
      });
    }
  }
}

class ProductData {
  int? id;
  String? nameAr;
  String? nameEn;
  String? description;
  String? weight;
  String? calories;
  double? noRating;
  String? image;
  List<Tags>? tags;
  double? price;
  double? salePrice = 0.0;
  bool? isActive;
  bool? isShalwata;
  int? isDelivered;
  int? isPickedUp;
  int? categoryId;
  int? subCategoryId;
  String? descriptionAr;
  String? descriptionEn;
  List<Images>? productImages;
  ExtraData? shalwata;
  List<ProductPaymentTypes>? productPaymentTypes;

  ProductData(
      {this.id,
      this.nameAr,
      this.nameEn,
      this.description,
      this.weight,
      this.calories,
      this.noRating,
      this.tags,
      this.image,
      this.price,
      this.salePrice,
      this.isActive,
      this.isShalwata,
      this.isDelivered,
      this.isPickedUp,
      this.categoryId,
      this.subCategoryId,
      this.descriptionAr,
      this.descriptionEn,
      this.shalwata,
      this.productPaymentTypes,
      this.productImages});

  ProductData.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    nameAr = json['name_ar'] ?? "";
    nameEn = json['name_en'] ?? "";
    description = json['description'] ?? "";
    weight = json['weight'] ?? "";
    calories = json['calories'] ?? "";
    noRating = (json['no_rating'] ?? 0.0) * 1.0;
    image = json['image'] ?? "";
    price = double.parse(json['price'] ?? "0.0");
    salePrice = double.parse(json['sale_price'] ?? "0.0");
    isActive = json['is_active'] ?? "";
    isShalwata = json['is_shalwata'] ?? "";
    isDelivered = json['is_delivered'] ?? "";
    isPickedUp = json['is_picked_up'] ?? "";
    categoryId = json['category_id'] ?? "";
    subCategoryId = json['sub_category_id'] ?? "";
    if (json['product_images'] != null) {
      productImages = <Images>[];
      json['product_images'].forEach((v) {
        productImages!.add(Images.fromJson(v));
      });
    }
    descriptionAr = json['description_ar'];
    descriptionEn = json['description_en'];
    shalwata =
        json['shalwata'] != null ? ExtraData.fromJson(json['shalwata']) : null;
    if (json['product_payment_types'] != null) {
      productPaymentTypes = <ProductPaymentTypes>[];
      json['product_payment_types'].forEach((v) {
        productPaymentTypes!.add(ProductPaymentTypes.fromJson(v));
      });
    }
    if (json['tags'] != null) {
      tags = <Tags>[];
      json['tags'].forEach((v) {
        tags!.add(Tags.fromJson(v));
      });
    }
  }
}

class ProductPaymentTypes {
  int? id;
  String? nameAr;
  String? nameEn;

  ProductPaymentTypes({this.id, this.nameAr, this.nameEn});

  ProductPaymentTypes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
  }
}

class Tags {
  String? nameAr;
  String? nameEn;
  String? color;

  Tags({this.nameAr, this.nameEn, this.color});

  Tags.fromJson(Map<String, dynamic> json) {
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    color = json['color'];
  }
}
