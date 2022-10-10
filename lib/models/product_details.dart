import 'category.dart';
import 'extra.dart';
import 'images.dart';

class ProductDetails {
  Data? data;
  ProductDetails({this.data});

  ProductDetails.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? id;
  String? nameAr;
  String? nameEn;
  String? price;
  String? salePrice;
  String? weight;
  String? calories;
  String? descriptionAr;
  bool isFavourite = false;
  String? descriptionEn;
  double? noRating;
  Category? category;
  SubCategory? subCategory;
  int? isPickedUp;
  int? isDelivered;
  bool? isShalwata;
  ExtraData? shalwata;
  bool? isActive;
  List<Images>? images;
  List<ExtraData>? sizes;
  List<ExtraData>? packaging;
  List<ExtraData>? chopping;
  bool? isAvailable;
  bool? isKwar3;
  bool? isRas;
  bool? isLyh;
  bool? isKarashah;

  Data(
      {this.id,
      this.nameAr,
      this.nameEn,
      this.price,
      this.salePrice,
      this.weight,
      this.calories,
      this.noRating,
      this.isKwar3,
      this.isRas,
      this.isLyh,
      this.isKarashah,
      this.category,
      this.subCategory,
      this.isPickedUp,
      this.descriptionAr,
      this.descriptionEn,
      this.isDelivered,
      this.isAvailable,
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
    salePrice = json['sale price'] ?? '0.0';
    weight = json['weight'] ?? '';
    isAvailable = json['is_available'];
    isKwar3 = json['is_kwar3'];
    isRas = json['is_Ras'];
    isLyh = json['is_lyh'];
    isKarashah = json['is_karashah'];
    descriptionAr = json['description_ar'] ?? '';
    descriptionEn = json['description_en'] ?? '';
    calories = json['calories'] ?? '';
    noRating = (json['no_rating'] ?? 5.0) * 1.0;
    category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
    subCategory = json['sub_category'] != null
        ? SubCategory.fromJson(json['sub_category'])
        : null;
    isPickedUp = json['is_picked_up'] ?? 0;
    isDelivered = json['is_delivered'] ?? 0;
    isShalwata = json['is_shalwata'] ?? false;
    shalwata =
        json['shalwata'] != null ? ExtraData.fromJson(json['shalwata']) : null;
    isActive = json['is_active'] ?? 1;

    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
    if (json['sizes'] != null) {
      sizes = <ExtraData>[];
      json['sizes'].forEach((v) {
        sizes!.add(ExtraData.fromJson(v));
      });
    }
    if (json['cuts'] != null) {
      chopping = <ExtraData>[];
      json['cuts'].forEach((v) {
        chopping!.add(ExtraData.fromJson(v));
      });
    }
    if (json['preparations'] != null) {
      packaging = <ExtraData>[];
      json['preparations'].forEach((v) {
        packaging!.add(ExtraData.fromJson(v));
      });
    }
  }
}


class SubCategory {
  int? id;
  int? categoryId;
  String? typeAr;
  String? typeEn;
  String? description;
  String? imageUrl;

  SubCategory({
    this.id,
    this.categoryId,
    this.typeAr,
    this.typeEn,
    this.description,
    this.imageUrl,
  });

  SubCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    typeAr = json['type_ar'] ?? "";
    typeEn = json['type_en'] ?? "";
    description = json['description'] ?? "";
    imageUrl = json['image_url'] ?? "";
  }
}
