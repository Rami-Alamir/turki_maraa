class Cart {
  final List<CartItem> items;
  final InvoiceData invoice;
  Cart({
    required this.items,
    required this.invoice,
  });
}

class InvoiceData {
  final double subtotal;
  final double total;
  final double shipping;

  InvoiceData({
    required this.total,
    required this.subtotal,
    required this.shipping,
  });
}

class CartItem {
  final String nameAr;
  final String nameEn;
  final String extraAr;
  final String extraEn;
  final String qty;
  final String price;
  final String image;

  CartItem({
    required this.nameAr,
    required this.nameEn,
    required this.extraAr,
    required this.extraEn,
    required this.qty,
    required this.price,
    required this.image,
  });
}
