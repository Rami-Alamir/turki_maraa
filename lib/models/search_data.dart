class SearchData {
  int? id;
  String? nameAr;
  String? nameEn;
  String? descriptionAr;
  String? descriptionEn;
  String? price;
  String? salePrice;
  bool? isActive;

  SearchData({
    this.id,
    this.nameAr,
    this.nameEn,
    this.descriptionAr,
    this.descriptionEn,
    this.price,
    this.salePrice,
    this.isActive,
  });

  SearchData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    descriptionAr = json['description_ar'];
    descriptionEn = json['description_en'];
    price = json['price'] ?? "0.0";
    salePrice = json['sale_price'] ?? "0.0";
    isActive = json['is_active'];
  }
}
