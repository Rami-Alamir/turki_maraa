class UserAddress {
  bool? success;
  List<Data>? data;
  String? message;
  String? description;
  String? code;

  UserAddress(
      {this.success, this.data, this.message, this.description, this.code});

  UserAddress.fromJson(Map<String, dynamic> json) {
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
  int? customerId;
  int? countryId;
  int? cityId;
  String? address;
  String? comment;
  String? label;
  String? isDefault;
  String? long;
  String? lat;

  Data(
      {this.id,
      this.customerId,
      this.countryId,
      this.cityId,
      this.address,
      this.comment,
      this.label,
      this.isDefault,
      this.long,
      this.lat});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    countryId = json['country_id'];
    cityId = json['city_id'];
    address = json['address'];
    comment = json['comment'];
    label = json['label'];
    isDefault = json['is_default'];
    long = json['long'];
    lat = json['lat'];
  }
}
