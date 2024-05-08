class OrderRef {
  bool? success;
  Data? data;
  String? code;

  OrderRef({this.success, this.data, this.code});

  OrderRef.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    code = json['code'];
  }
}

class Data {
  String? paymentRef;
  String? orderRef;

  Data({this.paymentRef, this.orderRef});

  Data.fromJson(Map<String, dynamic> json) {
    paymentRef = json['payment_ref'];
    orderRef = json['order_ref'];
  }
}
