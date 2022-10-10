class DiscoverData {
  List<Data>? data;

  DiscoverData({this.data});

  DiscoverData.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }
}

class Data {
  int? id;
  String? titleAr;
  String? titleEn;
  String? image;

  Data({
    this.id,
    this.titleAr,
    this.titleEn,
    this.image,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    titleAr = json['titel_ar'];
    titleEn = json['titel_en'];
    image = json['image'];
  }
}
