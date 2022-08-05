class AppVersion {
  bool? success;
  String? message;
  String? description;
  String? code;
  Data? data;

  AppVersion(
      {this.success, this.message, this.description, this.code, this.data});

  AppVersion.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    description = json['description'];
    code = json['code'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? id;
  String? key;
  String? value;

  Data({this.id, this.key, this.value});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    value = json['value'];
  }
}
