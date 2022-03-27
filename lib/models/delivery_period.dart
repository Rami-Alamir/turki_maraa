class DeliveryPeriod {
  List<Data>? data;

  DeliveryPeriod({this.data});

  DeliveryPeriod.fromJson(Map<String, dynamic> json) {
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
  String? nameAr;
  String? nameEn;

  Data({
    this.id,
    this.nameAr,
    this.nameEn,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
  }
}
