import 'images.dart';

class SearchData {
  int? id;
  int? categoryId;
  String? nameAr;
  String? nameEn;
  String? price;
  String? salePrice;

  List<Images>? productImages;

  SearchData(
      {this.id,
      this.categoryId,
      this.nameAr,
      this.nameEn,
      this.price,
      this.salePrice,
      this.productImages});

  SearchData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    price = json['price'] ?? "";
    salePrice = json['sale_price'] ?? "";
    if (json['product_images'] != null) {
      productImages = <Images>[];
      json['product_images'].forEach((v) {
        productImages!.add(Images.fromJson(v));
      });
    }
  }
}
