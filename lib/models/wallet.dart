class Wallet {
  WalletData? data;

  Wallet({this.data});

  Wallet.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? WalletData.fromJson(json['data']) : null;
  }
}

class WalletData {
  String? wallet;
  List<WalletLogs>? walletLogs;

  WalletData({this.wallet, this.walletLogs});

  WalletData.fromJson(Map<String, dynamic> json) {
    wallet = json['wallet'];
    if (json['wallet_logs'] != null) {
      walletLogs = <WalletLogs>[];
      json['wallet_logs'].forEach((v) {
        walletLogs!.add(WalletLogs.fromJson(v));
      });
    }
  }
}

class WalletLogs {
  String? lastAmount;
  String? newAmount;
  String? action;
  String? actionId;
  String? createdAt;

  WalletLogs(
      {this.lastAmount,
      this.newAmount,
      this.action,
      this.actionId,
      this.createdAt});

  WalletLogs.fromJson(Map<String, dynamic> json) {
    lastAmount = json['last_amount'];
    newAmount = json['new_amount'];
    action = json['action'];
    actionId = json['action_id'];
    createdAt = json['created_at'];
  }
}
