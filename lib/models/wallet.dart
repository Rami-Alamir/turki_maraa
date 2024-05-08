import 'package:flutter/material.dart';

class Wallet {
  final String? sId;
  final double? before;
  final double? after;
  final String? description;
  final Color? color;
  final IconData? iconData;
  final String? userId;
  final String? date;

  Wallet(
      {this.sId,
      this.before,
      this.color,
      this.after,
      this.date,
      this.iconData,
      this.description,
      this.userId});

  factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
        sId: json["_id"],
        before: (json["before"] ?? 0) * 1.0,
        after: (json["after"] ?? 0) * 1.0,
        description: json["description"],
        userId: json["userId"],
      );
}
