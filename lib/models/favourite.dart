import 'product.dart';

class Favourite {
  DataT? dataT;

  Favourite({this.dataT});

  Favourite.fromJson(Map<String, dynamic> json) {
    dataT = json['data'] != null ? DataT.fromJson(json['data']) : null;
  }
}

class DataT {
  List<Data>? data;

  DataT({this.data});

  DataT.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }
}

class Data {
  ProductData? product;
  int? id;
  Data({this.product, this.id});

  Data.fromJson(Map<String, dynamic> json) {
    product =
        json['product'] != null ? ProductData.fromJson(json['product']) : null;
    id = json['id'];
  }
}
