class BannersData {
  List<Data>? data;

  BannersData({this.data});

  BannersData.fromJson(Map<String, dynamic> json) {
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
  String? title;
  String? subTitle;
  String? redirectUrl;
  String? redirectMobileUrl;
  String? type;
  int? productId;
  int? categoryId;
  String? url;

  Data(
      {this.id,
      this.title,
      this.subTitle,
      this.redirectUrl,
      this.redirectMobileUrl,
      this.type,
      this.productId,
      this.categoryId,
      this.url});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    subTitle = json['sub_title'];
    redirectUrl = json['redirect_url'];
    redirectMobileUrl = json['redirect_mobile_url'];
    type = json['type'];
    productId = json['product_id'];
    categoryId = json['category_id'];
    url = json['url'];
  }
}
