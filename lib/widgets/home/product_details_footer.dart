import 'package:flutter/material.dart';
import 'package:new_turki/provider/auth.dart';
import 'package:new_turki/provider/cart_provider.dart';
import 'package:new_turki/provider/home_provider.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:new_turki/widgets/shared/rounded_rectangle_button.dart';
import 'package:provider/provider.dart';

class ProductDetailsFooter extends StatelessWidget {
  final int count;
  final Function add;
  final Function subtract;

  const ProductDetailsFooter(
      {required this.count, required this.add, required this.subtract});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      width: SizeConfig.screenWidth,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                RoundedRectangleButton(
                  padding: EdgeInsets.all(0),
                  onPressed: () {
                    subtract();
                  },
                  width: 40,
                  height: 40,
                  fontSize: 22,
                  title: '-',
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "$count",
                    style: Theme.of(context)
                        .textTheme
                        .headline1
                        ?.copyWith(fontSize: 16),
                  ),
                ),
                RoundedRectangleButton(
                  onPressed: () {
                    add();
                  },
                  padding: EdgeInsets.all(0),
                  width: 40,
                  height: 40,
                  fontSize: 22,
                  title: '+',
                ),
                RoundedRectangleButton(
                  onPressed: () {
                    final _homeProvider =
                        Provider.of<HomeProvider>(context, listen: false);
                    final _authProvider =
                        Provider.of<Auth>(context, listen: false);
                    final _cartProvider =
                        Provider.of<CartProvider>(context, listen: false);
                    if (_authProvider.isAuth) {
                      _cartProvider.addToCart(
                        context: context,
                        authorization: "Bearer " + _authProvider.accessToken,
                        quantity: '$count',
                        sizeId:
                            "${_homeProvider.selectedSize > -1 ? (_homeProvider.productData.data?.sizes?[_homeProvider.selectedSize].id!.toString()) : ""}",
                        preparationId:
                            "${_homeProvider.selectedPackaging > -1 ? (_homeProvider.productData.data?.packaging?[_homeProvider.selectedPackaging].id!.toString()) : ""}",
                        cutId:
                            "${_homeProvider.selectedChopping > -1 ? (_homeProvider.productData.data?.chopping?[_homeProvider.selectedChopping].id!.toString()) : ""}",
                        isShalwata:
                            "${_homeProvider.selectedShalwata > -1 ? (_homeProvider.productData.data?.shalwata!.id!.toString()) : ""}",
                        productId: '${_homeProvider.productData.data!.id}',
                      );
                    } else
                      Navigator.of(context, rootNavigator: true)
                          .pushNamed('/Login');
                  },
                  padding: EdgeInsets.all(0),
                  width: SizeConfig.screenWidth! - 150,
                  height: 40,
                  fontSize: 15,
                  title: AppLocalizations.of(context)!.tr('add_to_cart'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
