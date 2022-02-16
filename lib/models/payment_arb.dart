class PaymentARB {
  Data? data;

  PaymentARB({this.data});

  PaymentARB.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  String? invoiceURL;

  Data({this.invoiceURL});

  Data.fromJson(Map<String, dynamic> json) {
    invoiceURL = json['invoiceURL'];
  }
}
