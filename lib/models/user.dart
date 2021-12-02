class User {
  String? name;
  String? phone;
  String? email;
  String? nationality;
  String? category;
  double? orders;
  double? age;
  double? credit;
  double? point;
  double? lat;
  double? lng;

  User(
      {this.name,
      this.phone,
      this.email,
      this.nationality,
      this.orders,
      this.age,
      this.credit,
      this.category,
      this.point,
      this.lat,
      this.lng});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    credit = json['credit'];
    orders = json['orders'];
    point = json['point'];
    phone = json['phone'];
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.name;
    data['_id'] = this.phone;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}