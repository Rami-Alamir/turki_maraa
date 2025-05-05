import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../../controllers/app_provider.dart';
import '../../shared/rounded_rectangle_button.dart';
import '../../../../controllers/product_provider.dart';
import '../../../../controllers/cart_provider.dart';
import '../../../../core/constants/route_constants.dart';
import '../../../../core/service/service_locator.dart';
import '../../../../core/utilities/app_localizations.dart';
import '../../../../core/utilities/show_snack_bar.dart';
import '../../../../core/utilities/size_config.dart';

class ProductDetailsFooter extends StatefulWidget {
  final int count;
  final int index;
  final Function add;
  final Function subtract;
  final int categoryId;

  const ProductDetailsFooter(
      {super.key,
      required this.count,
      required this.index,
      required this.add,
      required this.subtract,
      required this.categoryId});
  @override
  State<ProductDetailsFooter> createState() => _ProductDetailsFooterState();
}

class _ProductDetailsFooterState extends State<ProductDetailsFooter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.onSurface,
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
                    HapticFeedback.heavyImpact();
                    widget.subtract();
                  },
                  width: 40,
                  height: 40,
                  fontSize: 22,
                  title: '-',
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "${widget.count}",
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge
                        ?.copyWith(fontSize: 16),
                  ),
                ),
                RoundedRectangleButton(
                  onPressed: () {
                    HapticFeedback.heavyImpact();
                    widget.add();
                  },
                  padding: const EdgeInsets.all(0),
                  width: 40,
                  height: 40,
                  fontSize: 22,
                  title: '+',
                ),
                RoundedRectangleButton(
                  onPressed: () async {
                    final ProductProvider productProvider =
                        Provider.of<ProductProvider>(context, listen: false);
                    final CartProvider cartProvider =
                        Provider.of<CartProvider>(context, listen: false);
                    if (cartProvider.isAuth) {
                      if (widget.categoryId ==
                              context
                                  .read<AppProvider>()
                                  .adhaConfig
                                  ?.categoryId &&
                          productProvider.selectedDay == -1 &&
                          context.read<AppProvider>().adhaConfig?.dates?.last !=
                              DateTime.now().toString().substring(0, 10)) {
                        sl<ShowSnackBar>().show(
                            context, "please_choose_the_day_of_sacrifice");
                        return;
                      }
                    }

                    if (cartProvider.isAuth) {
                      if ((productProvider.productData[widget.index].data?.sizes
                                      ?.length ??
                                  0) >
                              0 &&
                          productProvider.selectedSize == -1) {
                        sl<ShowSnackBar>().show(context, "please_select_size");
                        return;
                      }
                      if ((productProvider.productData[widget.index].data
                                      ?.chopping?.length ??
                                  0) >
                              0 &&
                          productProvider.selectedChopping == -1) {
                        sl<ShowSnackBar>().show(context, "please_select_cut");

                        return;
                      }
                      if ((productProvider.productData[widget.index].data
                                      ?.packaging?.length ??
                                  0) >
                              0 &&
                          productProvider.selectedPackaging == -1) {
                        sl<ShowSnackBar>().show(context, "please_select_pack");
                        return;
                      }
                      bool status = await cartProvider.addToCart(
                        context: context,
                        quantity: '${widget.count}',
                        sizeId:
                            "${productProvider.selectedSize > -1 ? (productProvider.productData[widget.index].data?.sizes?[productProvider.selectedSize].id!.toString()) : ""}",
                        preparationId:
                            "${productProvider.selectedPackaging > -1 ? (productProvider.productData[widget.index].data?.packaging?[productProvider.selectedPackaging].id!.toString()) : ""}",
                        cutId:
                            "${productProvider.selectedChopping > -1 ? (productProvider.productData[widget.index].data?.chopping?[productProvider.selectedChopping].id!.toString()) : ""}",
                        isShalwata:
                            "${productProvider.selectedShalwata ? (productProvider.productData[widget.index].data?.shalwata!.id!.toString()) : "0"}",
                        productId:
                            '${productProvider.productData[widget.index].data!.id}',
                        iskarashah: productProvider.withoutTripe ? "1" : "0",
                        isRas: productProvider.withoutHead ? "1" : "0",
                        isLyh: productProvider.withoutTailFat ? "1" : "0",
                        iskwar3: productProvider.withoutTrotters ? "1" : "0",
                      );
                      if (context.mounted) {
                        Navigator.of(context, rootNavigator: true).pop();
                        sl<ShowSnackBar>().show(context,
                            status ? "product_added_cart" : "unexpected_error");
                      }
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
