class TamaraData {
  List<Data>? data;

  TamaraData({this.data});

  TamaraData.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
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
    minLimit =
        json['min_limit'] != null ? MinLimit.fromJson(json['min_limit']) : null;
    maxLimit =
        json['max_limit'] != null ? MinLimit.fromJson(json['max_limit']) : null;
    if (json['supported_instalments'] != null) {
      supportedInstalments = <SupportedInstalments>[];
      json['supported_instalments'].forEach((v) {
        supportedInstalments!.add(SupportedInstalments.fromJson(v));
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
    minLimit =
        json['min_limit'] != null ? MinLimit.fromJson(json['min_limit']) : null;
    maxLimit =
        json['max_limit'] != null ? MinLimit.fromJson(json['max_limit']) : null;
  }
}
