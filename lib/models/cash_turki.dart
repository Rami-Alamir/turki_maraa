import 'wallet.dart' show TransactionLogs;

class CashTurki {
  CashTurkiData? data;

  CashTurki({this.data});

  CashTurki.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? CashTurkiData.fromJson(json['data']) : null;
  }
}

class CashTurkiData {
  String? cashturki;
  List<TransactionLogs>? cashTurkiLogs;

  CashTurkiData({this.cashturki, this.cashTurkiLogs});

  CashTurkiData.fromJson(Map<String, dynamic> json) {
    cashturki = json['cashturki'];
    if (json['cashturki_logs'] != null) {
      cashTurkiLogs = <TransactionLogs>[];
      json['cashturki_logs'].forEach((v) {
        cashTurkiLogs!.add(TransactionLogs.fromJson(v));
      });
    }
  }
}
