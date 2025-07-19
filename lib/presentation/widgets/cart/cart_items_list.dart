import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_card.dart';
import '../../../controllers/cart_provider.dart';

class CartItemsList extends StatelessWidget {
  const CartItemsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (_, cartProvider, _) {
        return ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: (cartProvider.cartData?.data?.cart?.data?.length ?? 0),
          itemBuilder: (BuildContext ctxt, int index) {
            return CartCard(
              item: cartProvider.cartData!.data!.cart!.data![index],
              index: index,
            );
          },
        );
      },
    );
  }
}
