class Favourite {
  DataT? dataT;

  Favourite({this.dataT});

  Favourite.fromJson(Map<String, dynamic> json) {
    dataT = json['data'] != null ? new DataT.fromJson(json['data']) : null;
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
  int? id;
  Data({this.product, this.id});

  Data.fromJson(Map<String, dynamic> json) {
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
    id = json['id'];
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
  String? image;
  String? price;
  String? salePrice;
  bool? isActive;
  bool? isShalwata;
  List<ProductImages>? productImages;

  Product({
    this.id,
    this.nameAr,
    this.nameEn,
    this.descriptionAr,
    this.descriptionEn,
    this.weight,
    this.calories,
    this.image,
    this.price,
    this.salePrice,
    this.isActive,
    this.isShalwata,
    this.productImages,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'] ?? "";
    nameEn = json['name_en'] ?? "";
    descriptionAr = json['description_ar'] ?? "";
    descriptionEn = json['description_en'] ?? "";
    weight = json['weight'] ?? "";
    calories = json['calories'] ?? "";
    image = json['image'] ??
        "https://turki.turkieshop.com/images/Jk78x2iKpI1608014433.png?431112";
    price = json['price'] ?? "";
    salePrice = json['sale_price'] ?? "";
    isActive = json['is_active'] ?? "";
    isShalwata = json['is_shalwata'] ?? "";
    if (json['product_images'] != null) {
      productImages = <ProductImages>[];
      json['product_images'].forEach((v) {
        productImages!.add(new ProductImages.fromJson(v));
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
