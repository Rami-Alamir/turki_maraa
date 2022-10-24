import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controllers/cart_provider.dart';
import '../../../controllers/products_provider.dart';
import '../../../core/constants/route_constants.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/show_snack_bar.dart';
import '../../../core/utilities/size_config.dart';
import '../shared/rounded_rectangle_button.dart';

class ProductDetailsFooter extends StatelessWidget {
  final int count;
  final int index;
  final Function add;
  final Function subtract;

  const ProductDetailsFooter(
      {Key? key,
      required this.count,
      required this.index,
      required this.add,
      required this.subtract})
      : super(key: key);

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
                  padding: const EdgeInsets.all(0),
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
                  padding: const EdgeInsets.all(0),
                  width: 40,
                  height: 40,
                  fontSize: 22,
                  title: '+',
                ),
                RoundedRectangleButton(
                  onPressed: () {
                    final ProductsProvider productsProvider =
                        Provider.of<ProductsProvider>(context, listen: false);
                    final CartProvider cartProvider =
                        Provider.of<CartProvider>(context, listen: false);
                    if (cartProvider.isAuth) {
                      if ((productsProvider
                                      .productData[index].data?.sizes?.length ??
                                  0) >
                              0 &&
                          productsProvider.selectedSize == -1) {
                        ShowSnackBar().show(context, "please_select_size");
                        return;
                      }
                      if ((productsProvider.productData[index].data?.chopping
                                      ?.length ??
                                  0) >
                              0 &&
                          productsProvider.selectedChopping == -1) {
                        ShowSnackBar().show(context, "please_select_cut");

                        return;
                      }
                      if ((productsProvider.productData[index].data?.packaging
                                      ?.length ??
                                  0) >
                              0 &&
                          productsProvider.selectedPackaging == -1) {
                        ShowSnackBar().show(context, "please_select_pack");
                        return;
                      }
                      cartProvider.addToCart(
                        context: context,
                        quantity: '$count',
                        sizeId:
                            "${productsProvider.selectedSize > -1 ? (productsProvider.productData[index].data?.sizes?[productsProvider.selectedSize].id!.toString()) : ""}",
                        preparationId:
                            "${productsProvider.selectedPackaging > -1 ? (productsProvider.productData[index].data?.packaging?[productsProvider.selectedPackaging].id!.toString()) : ""}",
                        cutId:
                            "${productsProvider.selectedChopping > -1 ? (productsProvider.productData[index].data?.chopping?[productsProvider.selectedChopping].id!.toString()) : ""}",
                        isShalwata:
                            "${productsProvider.selectedShalwata ? (productsProvider.productData[index].data?.shalwata!.id!.toString()) : "0"}",
                        productId:
                            '${productsProvider.productData[index].data!.id}',
                        iskarashah: productsProvider.withoutTripe ? "1" : "0",
                        isRas: productsProvider.withoutHead ? "1" : "0",
                        isLyh: productsProvider.withoutTailFat ? "1" : "0",
                        iskwar3: productsProvider.withoutTrotters ? "1" : "0",
                      );
                    } else {
                      Navigator.of(context, rootNavigator: true)
                          .pushNamed(login);
                    }
                  },
                  padding: const EdgeInsets.all(0),
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
