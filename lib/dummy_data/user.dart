class Addresses {
  String? description;
  String? sId;
  double? lat;
  double? lng;

  Addresses({this.description, this.sId, this.lat, this.lng});

  Addresses.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    sId = json['_id'];
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['_id'] = this.sId;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}
