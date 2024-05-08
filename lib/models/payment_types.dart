class PaymentTypes {
  List<Data>? data;

  PaymentTypes({this.data});

  PaymentTypes.fromJson(Map<String, dynamic> json) {
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
  String? nameAr;
  String? nameEn;
  String? code;
  int? active;

  Data({this.id, this.nameAr, this.nameEn, this.code, this.active});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    code = json['code'];
    active = json['active'];
  }
}
