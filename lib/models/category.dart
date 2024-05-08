class Category {
  int? id;
  String? typeAr;
  String? typeEn;
  String? description;
  String? imageUrl;

  Category({
    this.id,
    this.typeAr,
    this.typeEn,
    this.description,
    this.imageUrl,
  });

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    typeAr = json['type_ar'] ?? "";
    typeEn = json['type_en'] ?? "";
    description = json['description'] ?? "";
    imageUrl = json['banner_url'] ?? "";
  }
}
