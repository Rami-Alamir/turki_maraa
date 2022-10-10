class InvoicePreview {
  double? deliveryFee;
  double? orderSubtotal;
  double? totalAmount;
  double? discountApplied;
  double? totalAmountAfterDiscount;
  String? appliedDiscountCode;
  int? usingWallet;
  double? walletAmountUsed;

  InvoicePreview(
      {this.deliveryFee,
      this.orderSubtotal,
      this.totalAmount,
      this.totalAmountAfterDiscount,
      this.appliedDiscountCode,
      this.usingWallet,
      this.walletAmountUsed});

  InvoicePreview.fromJson(Map<String, dynamic> json) {
    deliveryFee = (json['delivery_fee'] ?? 0) * 1.0;
    discountApplied = (json['discount_applied'] ?? 0.0) * 1.0;
    orderSubtotal = (json['order_subtotal'] ?? 0) * 1.0;
    totalAmount = (json['total_amount'] ?? 0) * 1.0;
    totalAmountAfterDiscount = (json['total_amount_after_discount'] ?? 0) * 1.0;
    appliedDiscountCode = json['applied_discount_code'];
    usingWallet = json['using_wallet'];
    walletAmountUsed = (json['wallet_amount_used'] ?? 0) * 1.0;
  }
}
