class CartData {
  Data? data;

  CartData({this.data});

  CartData.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  List<ItemData>? data;
  List<Links>? links;
  double? total;

  Data({this.data, this.links});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ItemData>[];
      json['data'].forEach((v) {
        data!.add(ItemData.fromJson(v));
      });
    }
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(new Links.fromJson(v));
      });
    }
    total = json['total'] * 1.0;
  }
}

class ItemData {
  int? id;
  int? quantity;
  int? customerId;
  int? preparationId;
  int? sizeId;
  int? cutId;
  int? isShalwata;
  int? productId;
  String? createdAt;
  String? updatedAt;
  Product? product;
  Cut? cut;
  Cut? size;
  Cut? preparation;

  ItemData(
      {this.id,
      this.quantity,
      this.customerId,
      this.preparationId,
      this.sizeId,
      this.cutId,
      this.isShalwata,
      this.productId,
      this.createdAt,
      this.updatedAt,
      this.product,
      this.cut,
      this.size,
      this.preparation});

  ItemData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    customerId = json['customer_id'];
    preparationId = json['preparation_id'];
    sizeId = json['size_id'];
    cutId = json['cut_id'];
    isShalwata = json['is_shalwata'];
    productId = json['product_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
    cut = json['cut'] != null ? Cut.fromJson(json['cut']) : null;
    size = json['size'] != null ? Cut.fromJson(json['size']) : null;
    preparation = json['preparation'] != null
        ? new Cut.fromJson(json['preparation'])
        : null;
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
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    description = json['description'];
    weight = json['weight'];
    calories = json['calories'];
    noRating = json['no_rating'];
    price = json['price'];
    salePrice = json['sale_price'];
    isActive = json['is_active'];
    isShalwata = json['is_shalwata'];
    isDelivered = json['is_delivered'];
    isPickedUp = json['is_picked_up'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
  }
}

class Cut {
  int? id;
  String? nameAr;
  String? nameEn;
  String? price;

  Cut({this.id, this.nameAr, this.nameEn, this.price});

  Cut.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    price = json['price'];
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }
}
