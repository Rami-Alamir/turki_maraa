class Promotions {
  List<Data>? data;

  Promotions({this.data});

  Promotions.fromJson(Map<String, dynamic> json) {
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
  String? titleEn;
  String? titleAr;
  String? subTitleEn;
  String? subTitleAr;
  String? titleColor;
  String? subTitleColor;
  String? redirectUrl;
  String? redirectMobileUrl;
  int? isActive;
  String? type;
  String? image;
  String? createdAt;
  String? updatedAt;
  String? url;

  Data(
      {this.id,
      this.titleEn,
      this.titleAr,
      this.subTitleEn,
      this.subTitleAr,
      this.titleColor,
      this.subTitleColor,
      this.redirectUrl,
      this.redirectMobileUrl,
      this.isActive,
      this.type,
      this.image,
      this.createdAt,
      this.updatedAt,
      this.url});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    titleEn = json['title_en'];
    titleAr = json['title_ar'];
    subTitleEn = json['sub_title_en'];
    subTitleAr = json['sub_title_ar'];
    titleColor = json['title_color'];
    subTitleColor = json['sub_title_color'];
    redirectUrl = json['redirect_url'];
    redirectMobileUrl = json['redirect_mobile_url'];
    isActive = json['is_active'];
    type = json['type'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    url = json['url'];
  }
}
