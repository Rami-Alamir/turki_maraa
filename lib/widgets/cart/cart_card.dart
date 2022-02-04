import 'package:flutter/material.dart';
import 'package:new_turki/models/cart_data.dart';
import 'package:new_turki/provider/auth.dart';
import 'package:new_turki/provider/cart_provider.dart';
import 'package:new_turki/provider/favourite_provider.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:new_turki/widgets/shared/main_card.dart';
import 'package:new_turki/widgets/shared/rounded_rectangle_button.dart';
import 'package:provider/provider.dart';

class CartCard extends StatelessWidget {
  final ItemData item;
  final int index;
  const CartCard({
    required this.item,
    required this.index,
  });
  @override
  Widget build(BuildContext context) {
    final bool _language = AppLocalizations.of(context)!.locale == Locale('ar');
    final _cartProvider = Provider.of<CartProvider>(context, listen: false);

    return Container(
      width: SizeConfig.screenWidth,
      child: Dismissible(
        key: UniqueKey(),
        // key: Key(item.product!.id.toString() + "$index"),
        onDismissed: (direction) {
          if (direction == DismissDirection.endToStart) {
            delete(context, _cartProvider);
          } else {
            final favourite =
                Provider.of<FavouriteProvider>(context, listen: false);
            final auth = Provider.of<Auth>(context, listen: false);
            favourite.addToFavourite(
                context: context,
                withDialog: false,
                authorization: "Bearer ${auth.accessToken}",
                id: '${item.product!.id!}');
            delete(context, _cartProvider);
          }
        },
        background: Container(
          color: Colors.green,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                const Icon(Icons.favorite, color: Colors.white),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: Text(
                      AppLocalizations.of(context)!.tr('add_to_favorites'),
                      style:
                          const TextStyle(color: Colors.white, fontSize: 12)),
                ),
              ],
            ),
          ),
        ),
        secondaryBackground: Container(
          color: Colors.red,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Icon(Icons.delete, color: Colors.white),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: Text(AppLocalizations.of(context)!.tr('remove'),
                      style:
                          const TextStyle(color: Colors.white, fontSize: 12)),
                ),
              ],
            ),
          ),
        ),
        child: MainCard(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1.5),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image.network(
                        item.product!.productImages!.length > 0
                            ? item.product!.productImages![0].imageUrl!
                            : "https://turkieshop.com/images/Jk78x2iKpI1608014433.png?431112",
                        width: SizeConfig.setWidgetWidth(100, 135, 135),
                        height: SizeConfig.setWidgetHeight(100, 135, 135),
                        fit: BoxFit.cover,
                      )),
                ),
                Container(
                  constraints: BoxConstraints(
                      minHeight: SizeConfig.setWidgetWidth(100, 135, 135)),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        10.0, 5.0, 0.0, 0.0),
                    child: Container(
                      width: SizeConfig.screenWidth! -
                          SizeConfig.setWidgetWidth(150, 185, 185),
                      constraints: BoxConstraints(
                          minHeight: SizeConfig.setWidgetWidth(100, 135, 135)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  _language
                                      ? item.product!.nameAr!
                                      : item.product!.nameEn!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1!
                                      .copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700)),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5.0),
                                child: Text(
                                    _language
                                        ? "${item.size?.nameAr ?? ""} ${item.cut?.nameAr ?? ""} ${item.preparation?.nameAr ?? ""} ${item.isShalwata == 1 ? "مع شلوطة" : ""}"
                                        : "${item.size?.nameEn ?? ""} ${item.cut?.nameEn ?? ""} ${item.preparation?.nameEn ?? ""} ${item.isShalwata == 1 ? "with shalwata" : ""}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5!
                                        .copyWith(
                                          fontSize: 12,
                                        )),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                children: [
                                  RoundedRectangleButton(
                                    padding: const EdgeInsets.all(0),
                                    onPressed: () {
                                      if (item.quantity! <= 1)
                                        delete(context, _cartProvider);
                                      else
                                        _cartProvider.updateCartItem(
                                          context: context,
                                          productId: item.id.toString(),
                                          quantity:
                                              (item.quantity! - 1).toString(),
                                        );
                                    },
                                    width: 30,
                                    height: 30,
                                    fontSize: 22,
                                    title: '-',
                                  ),
                                  Text(
                                    item.quantity.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1
                                        ?.copyWith(fontSize: 16),
                                  ),
                                  RoundedRectangleButton(
                                    onPressed: () {
                                      _cartProvider.updateCartItem(
                                        context: context,
                                        productId: item.id.toString(),
                                        quantity:
                                            (item.quantity! + 1).toString(),
                                      );
                                    },
                                    padding: const EdgeInsets.all(0),
                                    width: 30,
                                    height: 30,
                                    fontSize: 22,
                                    title: '+',
                                  )
                                ],
                              ),
                              Text(
                                (_cartProvider.getPrice(index) * item.quantity!)
                                    .toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1
                                    ?.copyWith(
                                      fontSize: 14,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void delete(BuildContext context, CartProvider cartProvider) {
    cartProvider.deleteCartItem(
      context: context,
      productId: item.id.toString(),
    );
  }
}
