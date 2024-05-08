import 'product.dart';

class DiscoverItem {
  Data? data;

  DiscoverItem({this.data});

  DiscoverItem.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? id;
  String? titelAr;
  String? titelEn;
  String? subTitelAr;
  String? subTitelEn;
  String? descriptionAr;
  String? descriptionEn;
  String? subImage;
  List<ProductData>? products;

  Data(
      {this.id,
      this.titelAr,
      this.titelEn,
      this.subTitelAr,
      this.subTitelEn,
      this.descriptionAr,
      this.descriptionEn,
      this.subImage,
      this.products});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    titelAr = json['titel_ar'];
    titelEn = json['titel_en'];
    subTitelAr = json['sub_titel_ar'];
    subTitelEn = json['sub_titel_en'];
    descriptionAr = json['description_ar'];
    descriptionEn = json['description_en'];
    subImage = json['sub_image'] ?? "";
    if (json['products'] != null) {
      products = <ProductData>[];
      json['products'].forEach((v) {
        products!.add(ProductData.fromJson(v));
      });
    }
  }
}
