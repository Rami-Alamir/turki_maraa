import 'order.dart';
import 'product.dart';

class OrdersData {
  List<Data>? data;

  OrdersData({this.data});

  OrdersData.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }
}

class Data {
  String? refNo;
  String? deliveryFee;
  String? orderSubtotal;
  String? totalAmount;
  String? totalAmountAfterDiscount;
  String? comment;
  int? usingWallet;
  String? walletAmountUsed;
  String? discountApplied;
  String? address;
  int? addressId;
  int? shalwataId;
  int? customerId;
  int? orderStateId;
  int? paymentTypeId;
  int? deliveryPeriodId;
  int? deliveryDateId;
  String? createdAt;
  String? updatedAt;
  OrderState? orderState;
  List<Products>? products;
  DeliveryPeriod? deliveryPeriod;
  String? deliveryDate;
  List<OrderProducts>? orderProducts;

  Data(
      {this.refNo,
      this.deliveryFee,
      this.orderSubtotal,
      this.totalAmount,
      this.totalAmountAfterDiscount,
      this.comment,
      this.usingWallet,
      this.walletAmountUsed,
      this.discountApplied,
      this.address,
      this.addressId,
      this.shalwataId,
      this.customerId,
      this.orderStateId,
      this.paymentTypeId,
      this.deliveryPeriodId,
      this.deliveryDateId,
      this.createdAt,
      this.updatedAt,
      this.orderState,
      this.orderProducts,
      this.products,
      this.deliveryPeriod,
      this.deliveryDate});

  Data.fromJson(Map<String, dynamic> json) {
    refNo = json['ref_no'];
    if (json['order_products'] != null) {
      orderProducts = <OrderProducts>[];
      json['order_products'].forEach((v) {
        orderProducts!.add(OrderProducts.fromJson(v));
      });
    }
    deliveryFee = json['delivery_fee'];
    orderSubtotal = json['order_subtotal'];
    totalAmount = json['total_amount'];
    totalAmountAfterDiscount = json['total_amount_after_discount'];
    comment = json['comment'];
    usingWallet = json['using_wallet'];
    walletAmountUsed = json['wallet_amount_used'];
    discountApplied = json['discount_applied'];
    address = json['address'];
    addressId = json['address_id'];
    shalwataId = json['shalwata_id'];
    customerId = json['customer_id'];
    orderStateId = json['order_state_id'];
    paymentTypeId = json['payment_type_id'];
    deliveryPeriodId = json['delivery_period_id'];
    deliveryDateId = json['delivery_date_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    orderState = json['order_state'] != null
        ? OrderState.fromJson(json['order_state'])
        : null;
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
    deliveryPeriod = json['delivery_period'] != null
        ? DeliveryPeriod.fromJson(json['delivery_period'])
        : null;
    deliveryDate = json['delivery_date'];
  }
}

class OrderProducts {
  int? id;
  int? quantity;
  ProductData? product;

  OrderProducts({this.id, this.quantity, this.product});

  OrderProducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    product =
        json['product'] != null ? ProductData.fromJson(json['product']) : null;
  }
}
