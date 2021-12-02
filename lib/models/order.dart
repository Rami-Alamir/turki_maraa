class Order {
  final String id;
  final String type;
  final String image;
  final String total;
  final String date;
  final String payment;
  final String address;
  final String status;
  final int statusCode;
  final List<OrderItem> orderItems;
  final Payment paymentMethod;
  Order(
      {required this.id,
      required this.type,
      required this.image,
      required this.total,
      required this.date,
      required this.statusCode,
      required this.payment,
      required this.address,
      required this.orderItems,
      required this.paymentMethod,
      required this.status});
}

class OrderItem {
  final int id;
  final String qty;
  final String title;
  final String subtitle;
  final String price;
  final String image;

  OrderItem(
      {required this.qty,
      required this.id,
      required this.title,
      required this.subtitle,
      required this.price,
      required this.image});
}

class Payment {
  final String title;
  final String image;

  Payment({required this.title, required this.image});
}
