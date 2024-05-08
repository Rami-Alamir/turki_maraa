class BannersData {
  List<Data>? data;

  BannersData({this.data});

  BannersData.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }
}

class Data {
  String? redirectUrl;
  String? redirectMobileUrl;
  String? type;
  int? productId;
  int? categoryId;
  String? url;

  Data(
      {this.redirectUrl,
      this.redirectMobileUrl,
      this.type,
      this.productId,
      this.categoryId,
      this.url});

  Data.fromJson(Map<String, dynamic> json) {
    redirectUrl = json['redirect_url'];
    redirectMobileUrl = json['redirect_mobile_url'];
    type = json['type'];
    productId = json['product_id'];
    categoryId = json['category_id'];
    url = json['url'];
  }
}
