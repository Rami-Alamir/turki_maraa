class DeliveryDate {
  bool? success;
  List<Data>? data;
  String? message;
  String? description;
  String? code;

  DeliveryDate(
      {this.success, this.data, this.message, this.description, this.code});

  DeliveryDate.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
    description = json['description'];
    code = json['code'];
  }
}

class Data {
  int? id;
  int? cityId;
  String? dateYyyymmdd;
  int? isActive;
  String? createdAt;
  String? updatedAt;
  List<DeliveryDatePeriods>? deliveryDatePeriods;

  Data(
      {this.id,
      this.cityId,
      this.dateYyyymmdd,
      this.isActive,
      this.createdAt,
      this.updatedAt,
      this.deliveryDatePeriods});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cityId = json['city_id'];
    dateYyyymmdd = json['date_yyyymmdd'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['delivery_date_periods'] != null) {
      deliveryDatePeriods = <DeliveryDatePeriods>[];
      json['delivery_date_periods'].forEach((v) {
        deliveryDatePeriods!.add(new DeliveryDatePeriods.fromJson(v));
      });
    }
  }
}

class DeliveryDatePeriods {
  int? id;
  String? nameAr;
  String? nameEn;
  int? isActive;
  String? timeHhmm;
  String? createdAt;
  String? updatedAt;

  DeliveryDatePeriods(
      {this.id,
      this.nameAr,
      this.nameEn,
      this.isActive,
      this.timeHhmm,
      this.createdAt,
      this.updatedAt});

  DeliveryDatePeriods.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    isActive = json['is_active'];
    timeHhmm = json['time_hhmm'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
