class AppVersion {
  Data? data;

  AppVersion({this.data});

  AppVersion.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? id;
  String? value;

  Data({this.id, this.value});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    value = json['value'];
  }
}
