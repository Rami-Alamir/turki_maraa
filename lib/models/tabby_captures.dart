class TabbyCaptures {
  String? id;
  String? createdAt;
  String? expiresAt;
  bool? isExpired;
  String? status;
  bool? cancelable;
  String? currency;
  String? amount;
  String? description;

  OrderReferenceId? order;
  List<Captures>? captures;

  TabbyCaptures({
    this.id,
    this.createdAt,
    this.expiresAt,
    this.isExpired,
    this.status,
    this.cancelable,
    this.currency,
    this.amount,
    this.description,
    this.order,
    this.captures,
  });

  TabbyCaptures.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    expiresAt = json['expires_at'];
    isExpired = json['is_expired'];
    status = json['status'];
    cancelable = json['cancelable'];
    currency = json['currency'];
    amount = json['amount'];
    description = json['description'];
    order =
        json['order'] != null ? OrderReferenceId.fromJson(json['order']) : null;
    if (json['captures'] != null) {
      captures = <Captures>[];
      json['captures'].forEach((v) {
        captures!.add(Captures.fromJson(v));
      });
    }
  }
}

class OrderReferenceId {
  String? referenceId;

  OrderReferenceId({
    this.referenceId,
  });

  OrderReferenceId.fromJson(Map<String, dynamic> json) {
    referenceId = json['reference_id'];
  }
}

class Captures {
  String? id;
  String? createdAt;
  String? amount;
  String? taxAmount;
  String? shippingAmount;
  String? discountAmount;

  Captures(
      {this.id,
      this.createdAt,
      this.amount,
      this.taxAmount,
      this.shippingAmount,
      this.discountAmount});

  Captures.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    amount = json['amount'];
    taxAmount = json['tax_amount'];
    shippingAmount = json['shipping_amount'];
    discountAmount = json['discount_amount'];
  }
}
