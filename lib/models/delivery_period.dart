class DeliveryPeriod {
  List<DeliveryPeriodData>? data;

  DeliveryPeriod({this.data});

  DeliveryPeriod.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <DeliveryPeriodData>[];
      json['data'].forEach((v) {
        data!.add(DeliveryPeriodData.fromJson(v));
      });
    }
  }
}

class DeliveryPeriodData {
  int? id;
  String? nameAr;
  String? nameEn;
  // String? from;
  // String? to;
  String? timeHhmm;
  DeliveryPeriodData({
    this.id,
    this.nameAr,
    this.nameEn,
    // this.from,
    // this.to,
    this.timeHhmm,
  });

  DeliveryPeriodData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    // from = json['from'];
    // to = json['to'];
    timeHhmm = json['time_hhmm'];
  }
}
