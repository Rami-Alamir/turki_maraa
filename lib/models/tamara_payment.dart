class TamaraPayment {
  Data? data;

  TamaraPayment({this.data});

  TamaraPayment.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  String? checkoutUrl;
  bool? success;

  Data({this.checkoutUrl, this.success});

  Data.fromJson(Map<String, dynamic> json) {
    checkoutUrl = json['checkout_url'];
    success = json['success'];
  }
}
