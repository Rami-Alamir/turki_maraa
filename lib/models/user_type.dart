class UserType {
  String? code;

  UserType({this.code});

  UserType.fromJson(Map<String, dynamic> json) {
    code = json['code'];
  }
}
