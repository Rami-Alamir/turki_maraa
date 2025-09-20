class Wallet {
  WalletData? data;

  Wallet({this.data});

  Wallet.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? WalletData.fromJson(json['data']) : null;
  }
}

class WalletData {
  String? wallet;
  List<TransactionLogs>? walletLogs;

  WalletData({this.wallet, this.walletLogs});

  WalletData.fromJson(Map<String, dynamic> json) {
    wallet = json['wallet'];
    if (json['wallet_logs'] != null) {
      walletLogs = <TransactionLogs>[];
      json['wallet_logs'].forEach((v) {
        walletLogs!.add(TransactionLogs.fromJson(v));
      });
    }
  }
}

class TransactionLogs {
  String? lastAmount;
  String? newAmount;
  String? action;
  String? messageAr;
  String? messageEn;
  String? expiryDate;
  String? actionId;
  String? createdAt;

  TransactionLogs({
    this.lastAmount,
    this.newAmount,
    this.action,
    this.messageAr,
    this.messageEn,
    this.expiryDate,
    this.actionId,
    this.createdAt,
  });

  TransactionLogs.fromJson(Map<String, dynamic> json) {
    lastAmount = json['last_amount'];
    newAmount = json['new_amount'];
    action = json['action'];
    messageAr = json['message_ar'];
    messageEn = json['message_en'];
    actionId = json['action_id'];
    expiryDate = json['expired_at'];
    createdAt = json['created_at'];
  }
}
