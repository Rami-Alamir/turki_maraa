import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_card.dart';
import '../../../controllers/cart_provider.dart';

class CartItemsList extends StatelessWidget {
  const CartItemsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CartProvider cart = Provider.of<CartProvider>(context);
    return ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: (cart.cartData?.data?.cart?.data?.length ?? 0),
        itemBuilder: (BuildContext ctxt, int index) {
          return CartCard(
            item: cart.cartData!.data!.cart!.data![index],
            index: index,
          );
        });
  }
}
