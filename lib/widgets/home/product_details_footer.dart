import 'package:flutter/material.dart';
import 'package:new_turki/provider/address_provider.dart';
import 'package:new_turki/provider/auth.dart';
import 'package:new_turki/provider/cart_provider.dart';
import 'package:new_turki/provider/products_provider.dart';
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
                    final _productsProvider =
                        Provider.of<ProductsProvider>(context, listen: false);
                    final _authProvider =
                        Provider.of<Auth>(context, listen: false);
                    final _addressProvider =
                        Provider.of<AddressProvider>(context, listen: false);
                    final _cartProvider =
                        Provider.of<CartProvider>(context, listen: false);
                    if (_authProvider.isAuth) {
                      if ((_productsProvider.productData.data?.sizes?.length ??
                                  0) >
                              0 &&
                          _productsProvider.selectedSize == -1) {
                        _cartProvider.showSnackBar(
                            context, 'please_select_size');
                        return;
                      }
                      if ((_productsProvider
                                      .productData.data?.chopping?.length ??
                                  0) >
                              0 &&
                          _productsProvider.selectedChopping == -1) {
                        _cartProvider.showSnackBar(
                            context, 'please_select_cut');
                        return;
                      }
                      if ((_productsProvider
                                      .productData.data?.packaging?.length ??
                                  0) >
                              0 &&
                          _productsProvider.selectedPackaging == -1) {
                        _cartProvider.showSnackBar(
                            context, 'please_select_pack');
                        return;
                      }
                      _cartProvider.addToCart(
                          context: context,
                          authorization: "Bearer " + _authProvider.accessToken,
                          quantity: '$count',
                          sizeId:
                              "${_productsProvider.selectedSize > -1 ? (_productsProvider.productData.data?.sizes?[_productsProvider.selectedSize].id!.toString()) : ""}",
                          preparationId:
                              "${_productsProvider.selectedPackaging > -1 ? (_productsProvider.productData.data?.packaging?[_productsProvider.selectedPackaging].id!.toString()) : ""}",
                          cutId:
                              "${_productsProvider.selectedChopping > -1 ? (_productsProvider.productData.data?.chopping?[_productsProvider.selectedChopping].id!.toString()) : ""}",
                          isShalwata:
                              "${_productsProvider.selectedShalwata ? (_productsProvider.productData.data?.shalwata!.id!.toString()) : "0"}",
                          productId:
                              '${_productsProvider.productData.data!.id}',
                          iskarashah:
                              '${_productsProvider.withoutTripe ? "1" : "0"}',
                          isRas: '${_productsProvider.withoutHead ? "1" : "0"}',
                          isLyh:
                              '${_productsProvider.withoutTailFat ? "1" : "0"}',
                          iskwar3:
                              '${_productsProvider.withoutTrotters ? "1" : "0"}',
                          isoCountryCode: _addressProvider.isoCountryCode,
                          latLng: _addressProvider.selectedLatLng);
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
