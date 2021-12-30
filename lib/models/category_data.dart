class CategoryData {
  List<Data>? data;

  CategoryData({this.data});

  CategoryData.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }
}

class Data {
  int? id;
  String? titleAr;
  String? titleEn;
  String? backgroundColor1;
  String? backgroundColor2;
  String? imageUrl;

  Data(
      {this.id,
      this.titleAr,
      this.titleEn,
      this.backgroundColor1,
      this.backgroundColor2,
      this.imageUrl});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    titleAr = json['type_ar'];
    titleEn = json['type_en'];
    backgroundColor1 = json['background color 1'];
    backgroundColor2 = json['background color 2'];
    imageUrl = json['image_url'];
  }
}
