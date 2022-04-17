class TamaraData {
  bool? success;
  List<Data>? data;
  String? message;
  String? description;
  int? code;

  TamaraData(
      {this.success, this.data, this.message, this.description, this.code});

  TamaraData.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? description;
  String? descriptionAr;
  MinLimit? minLimit;
  MinLimit? maxLimit;
  List<SupportedInstalments>? supportedInstalments;

  Data(
      {this.name,
      this.description,
      this.descriptionAr,
      this.minLimit,
      this.maxLimit,
      this.supportedInstalments});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    descriptionAr = json['description_ar'];
    minLimit = json['min_limit'] != null
        ? new MinLimit.fromJson(json['min_limit'])
        : null;
    maxLimit = json['max_limit'] != null
        ? new MinLimit.fromJson(json['max_limit'])
        : null;
    if (json['supported_instalments'] != null) {
      supportedInstalments = <SupportedInstalments>[];
      json['supported_instalments'].forEach((v) {
        supportedInstalments!.add(new SupportedInstalments.fromJson(v));
      });
    }
  }
}

class MinLimit {
  int? amount;
  String? currency;

  MinLimit({this.amount, this.currency});

  MinLimit.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    currency = json['currency'];
  }
}

class SupportedInstalments {
  int? instalments;
  MinLimit? minLimit;
  MinLimit? maxLimit;

  SupportedInstalments({this.instalments, this.minLimit, this.maxLimit});

  SupportedInstalments.fromJson(Map<String, dynamic> json) {
    instalments = json['instalments'];
    minLimit = json['min_limit'] != null
        ? new MinLimit.fromJson(json['min_limit'])
        : null;
    maxLimit = json['max_limit'] != null
        ? new MinLimit.fromJson(json['max_limit'])
        : null;
  }
}
