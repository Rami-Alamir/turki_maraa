import 'package:flutter/material.dart';
import 'package:new_turki/provider/auth.dart';
import 'package:new_turki/provider/cart_provider.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/widgets/cart/cart_card.dart';
import 'package:new_turki/widgets/cart/delivery_address.dart';
import 'package:new_turki/widgets/cart/delivery_date.dart';
import 'package:new_turki/widgets/cart/delivery_time.dart';
import 'package:new_turki/widgets/cart/empty_cart.dart';
import 'package:new_turki/widgets/cart/note.dart';
import 'package:new_turki/widgets/cart/payment_method.dart';
import 'package:new_turki/widgets/cart/promo_code.dart';
import 'package:new_turki/widgets/cart/use_credit.dart';
import 'package:new_turki/widgets/shared/not_auth.dart';
import 'package:new_turki/widgets/shared/primary_app_bar.dart';
import 'package:new_turki/widgets/shared/retry.dart';
import 'package:new_turki/widgets/shared/rounded_rectangle_button.dart';
import 'package:new_turki/widgets/shared/spinkit_indicator.dart';
import 'package:new_turki/widgets/shared/invoice.dart';
import 'package:provider/provider.dart';

class ShoppingCart extends StatefulWidget {
  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  @override
  Widget build(BuildContext context) {
    final _cart = Provider.of<CartProvider>(context);
    final _auth = Provider.of<Auth>(context, listen: false);
    return Scaffold(
      appBar: PrimaryAppBar(
        title: AppLocalizations.of(context)!.tr('cart'),
        back: false,
      ),
      body: _cart.cartLength == 0
          ? _cart.isLoading
              ? SpinkitIndicator()
              : _cart.retry
                  ? Retry(
                      onPressed: () {
                        _cart.reInitOrdersList();
                      },
                    )
                  : !_cart.isAuth
                      ? NotAuth()
                      : EmptyCart()
          : RefreshIndicator(
              color: Theme.of(context).primaryColor,
              backgroundColor: Theme.of(context).colorScheme.secondary,
              onRefresh: () async {
                await _cart.reInitOrdersList();
              },
              child: GestureDetector(
                onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
                child: ListView(
                  children: [
                    ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        itemCount: _cart.cartData.items.length,
                        itemBuilder: (BuildContext ctxt, int index) {
                          return CartCard(
                            item: _cart.cartData.items[index],
                            index: index,
                          );
                        }),
                    DeliveryAddress(address: _auth.deliveryAddress),
                    DeliveryDate(),
                    DeliveryTime(),
                    PaymentMethod(),
                    UseCredit(credit: "100.6"),
                    Note(),
                    PromoCode(),
                    Invoice(
                        myCredit: _cart.useCredit ? 100.6 : 0.0,
                        total: _cart.cartData.invoice.total -
                            (_cart.useCredit ? 100.6 : 0.0),
                        subtotal: _cart.cartData.invoice.subtotal,
                        shipping: _cart.cartData.invoice.shipping),
                    RoundedRectangleButton(
                        title: AppLocalizations.of(context)!.tr('place_order'),
                        onPressed: () {})
                  ],
                ),
              ),
            ),
    );
  }
}
