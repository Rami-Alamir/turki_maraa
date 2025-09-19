class CashTurki {
  List<Data>? data;

  CashTurki({this.data});

  CashTurki.fromJson(Map<String, dynamic> json) {
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
  String? lastAmount;
  String? newAmount;
  String? action;
  String? messageAr;
  String? messageEn;
  String? expiredAt;
  String? createdAt;

  Data({
    this.id,
    this.lastAmount,
    this.newAmount,
    this.action,
    this.messageAr,
    this.messageEn,
    this.expiredAt,
    this.createdAt,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lastAmount = json['last_amount'];
    newAmount = json['new_amount'];
    action = json['action'];
    messageAr = json['message_ar'];
    messageEn = json['message_en'];
    expiredAt = json['expired_at'];
    createdAt = json['created_at'];
  }
}
