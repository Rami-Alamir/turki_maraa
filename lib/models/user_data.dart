class UserData {
  Data? data;
  String? code;

  UserData({this.data, this.code});

  UserData.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    code = json['code'].toString();
  }
}

class Data {
  String? mobile;
  String? name;
  String? email;
  String? age;
  String? points;
  String? wallet;
  String? gender;
  int? id;
  String? accessToken;
  String? createdAt;

  Data(
      {this.mobile,
      this.id,
      this.name,
      this.wallet,
      this.gender,
      this.email,
      this.age,
      this.accessToken,
      this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    mobile = json['mobile'] ?? "";
    name = json['name'] ?? " ";
    email = json['email'] ?? " ";
    age = json['age'] ?? " ".toString();
    wallet = (json['wallet'] ?? "0").toString();
    gender = (json['gender'] ?? "").toString().trim();
    points = (json['loyalty_points'] ?? "0").toString();
    id = json['id'];
    accessToken = json['access_token'] ?? "";
    createdAt = json['created_at'] ?? "2022-11-26T10:52:54.000000Z";
  }
}
