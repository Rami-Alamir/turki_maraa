class SearchData {
  int? id;
  String? nameAr;
  String? nameEn;
  String? price;
  String? salePrice;

  List<ProductImages>? productImages;

  SearchData(
      {this.id,
      this.nameAr,
      this.nameEn,
      this.price,
      this.salePrice,
      this.productImages});

  SearchData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];

    price = json['price'] ?? "";
    salePrice = json['sale_price'] ?? "";

    if (json['product_images'] != null) {
      productImages = <ProductImages>[];
      json['product_images'].forEach((v) {
        productImages!.add(new ProductImages.fromJson(v));
      });
    }
  }
}

class ProductImages {
  String? imageUrl;

  ProductImages({
    this.imageUrl,
  });

  ProductImages.fromJson(Map<String, dynamic> json) {
    imageUrl = json['image_url'];
  }
}
