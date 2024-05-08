class DeliveryPeriod {
  List<Data>? data;

  DeliveryPeriod({this.data});

  DeliveryPeriod.fromJson(Map<String, dynamic> json) {
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
  // String? from;
  // String? to;
  String? timeHhmm;
  Data({
    this.id,
    this.nameAr,
    this.nameEn,
    // this.from,
    // this.to,
    this.timeHhmm,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    // from = json['from'];
    // to = json['to'];
    timeHhmm = json['time_hhmm'];
  }
}
