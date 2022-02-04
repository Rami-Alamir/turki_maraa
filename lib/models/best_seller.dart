class BestSeller {
  List<Data>? data;

  BestSeller({this.data});

  BestSeller.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }
}

class Data {
  int? id;
  String? nameAr;
  String? nameEn;
  double? price = 0.0;
  double? salePrice = 0.0;
  List<Images>? images;

  Data(
      {this.id,
      this.nameAr,
      this.nameEn,
      this.price,
      this.salePrice,
      this.images});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    price = double.parse(json['price'] ?? "0.0");
    salePrice = double.parse(json['sale price'] ?? "0.0");
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
  }
}

class Images {
  int? id;
  int? productId;
  String? imageUrl;

  Images({
    this.id,
    this.productId,
    this.imageUrl,
  });

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    imageUrl = json['image_url'];
  }
}
