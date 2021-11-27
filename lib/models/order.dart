class Order {
  final String id;
  final String type;
  final String image;
  final String total;
  final String date;
  final String payment;
  final String status;
  final List<OrderItem> orderItems;
  Order(
      {required this.id,
      required this.type,
      required this.image,
      required this.total,
      required this.date,
      required this.payment,
      required this.orderItems,
      required this.status});
}

class OrderItem {
  final String qty;
  final String title;

  OrderItem({required this.qty, required this.title});
}
