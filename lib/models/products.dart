class Products {
  List<Data>? data;

  Products({this.data});

  Products.fromJson(Map<String, dynamic> json) {
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
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    if (json['products'] != null) {
      products = <ProductData>[];
      json['products'].forEach((v) {
        products!.add(ProductData.fromJson(v));
      });
    }
  }
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
    id = json['id'];
    typeAr = json['type_ar'] ?? "";
    typeEn = json['type_en'] ?? "";
    description = json['description'] ?? "";
    imageUrl = json['image_url'] ?? "";
    thumbnailUrl = json['thumbnail_url'] ?? "";
  }
}

class ProductData {
  int? id;
  String? nameAr;
  String? nameEn;
  String? description;
  String? weight;
  String? calories;
  int? noRating;
  String? image;
  List<Tags>? tags;
  double? price;
  double? discount = 0.0;
  bool? isActive;
  bool? isShalwata;
  int? isDelivered;
  int? isPickedUp;
  int? categoryId;
  int? subCategoryId;

  List<ProductImages>? productImages;

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
      this.isActive,
      this.isShalwata,
      this.isDelivered,
      this.isPickedUp,
      this.categoryId,
      this.subCategoryId,
      this.productImages});

  ProductData.fromJson(Map<String, dynamic> json) {
    if (json['tags'] != null) {
      tags = <Tags>[];
      json['tags'].forEach((v) {
        tags!.add(Tags.fromJson(v));
      });
    }
    id = json['id'] ?? "";
    nameAr = json['name_ar'] ?? "";
    nameEn = json['name_en'] ?? "";
    description = json['description'] ?? "";
    weight = json['weight'] ?? "";
    calories = json['calories'] ?? "";
    noRating = json['no_rating'] ?? "";
    image = json['image'] ?? "";
    price = double.parse(json['price'] ?? 0.0);
    isActive = json['is_active'] ?? "";
    isShalwata = json['is_shalwata'] ?? "";
    isDelivered = json['is_delivered'] ?? "";
    isPickedUp = json['is_picked_up'] ?? "";
    categoryId = json['category_id'] ?? "";
    subCategoryId = json['sub_category_id'] ?? "";
    if (json['product_images'] != null) {
      productImages = <ProductImages>[];
      json['product_images'].forEach((v) {
        productImages!.add(ProductImages.fromJson(v));
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
    productId = json['product_id'] ?? "";
    isDefault = json['is_default'] ?? "";
    createdAt = json['created_at'] ?? "";
    updatedAt = json['updated_at'] ?? "";
    imageUrl = json['image_url'] ?? "";
    thumbnailUrl = json['thumbnail_url'] ?? "";
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_ar'] = this.nameAr;
    data['name_en'] = this.nameEn;
    data['color'] = this.color;
    return data;
  }
}
