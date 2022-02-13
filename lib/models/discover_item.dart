class DiscoverItem {
  Data? data;

  DiscoverItem({this.data});

  DiscoverItem.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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
  List<Products>? products;

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
    subImage = json['sub_image'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
  }
}

class Products {
  int? id;
  String? nameAr;
  String? nameEn;
  double? price;
  double? salePrice;
  List<Tags>? tags;
  List<ProductImages>? productImages;

  Products(
      {this.id,
      this.nameAr,
      this.nameEn,
      this.price,
      this.salePrice,
      this.productImages,
      this.tags});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'] ?? "";
    nameEn = json['name_en'] ?? "";
    price = double.parse(json['price'] ?? "0.0");
    salePrice = double.parse(json['sale_price'] ?? "0.0");

    if (json['product_images'] != null) {
      productImages = <ProductImages>[];
      json['product_images'].forEach((v) {
        productImages!.add(new ProductImages.fromJson(v));
      });
    }

    if (json['tags'] != null) {
      tags = <Tags>[];
      json['tags'].forEach((v) {
        tags!.add(new Tags.fromJson(v));
      });
    }
  }
}

class ProductImages {
  int? id;

  String? imageUrl;

  ProductImages({
    this.id,
    this.imageUrl,
  });

  ProductImages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageUrl = json['image_url'];
  }
}

class Tags {
  int? id;
  String? nameAr;
  String? nameEn;
  String? color;

  Tags({this.id, this.nameAr, this.nameEn, this.color});

  Tags.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    color = json['color'];
  }
}
