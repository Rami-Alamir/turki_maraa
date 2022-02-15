class UserAddress {
  List<Data>? data;

  UserAddress({this.data});

  UserAddress.fromJson(Map<String, dynamic> json) {
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
  int? customerId;
  int? countryId;
  String? countryIosCode;
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
      this.countryIosCode,
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
    countryIosCode = json['country_iso_code'] ?? "SA";
    cityId = json['city_id'];
    address = json['address'];
    comment = json['comment'];
    label = json['label'];
    isDefault = json['is_default'];
    long = json['long'];
    lat = json['lat'];
  }
}
