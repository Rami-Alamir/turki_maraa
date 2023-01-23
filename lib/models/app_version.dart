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
  String? url;
  String? urlAe;

  Data({this.id, this.value, this.url, this.urlAe});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    value = json['value'];
    url = json['url'];
    urlAe = json['url2'];
  }
}
