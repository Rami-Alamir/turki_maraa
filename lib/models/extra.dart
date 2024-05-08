class ExtraData {
  int? id;
  String? nameAr;
  String? nameEn;
  String? price;
  String? salePrice;
  String? weight;

  ExtraData(
      {this.id,
      this.nameAr,
      this.nameEn,
      this.price,
      this.salePrice,
      this.weight});

  ExtraData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    price = json['price'];
    salePrice = json['sale_price'] ?? "0";
    weight = json['weight'] ?? "";
  }
}
