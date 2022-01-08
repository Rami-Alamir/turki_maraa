import 'package:flutter/material.dart';
import 'package:new_turki/models/cart_data.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:new_turki/widgets/shared/main_card.dart';
import 'package:new_turki/widgets/shared/rounded_rectangle_button.dart';

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
    // final _cartProvider = Provider.of<CartProvider>(context);
    return Container(
      width: SizeConfig.screenWidth,
      child: Dismissible(
        key: Key(item.product!.id.toString() + "$index"),
        onDismissed: (direction) {
          if (direction == DismissDirection.endToStart) {
            //final _cart = Provider.of<CartProvider>(context, listen: false);
            //    _cart.removeCartItemData(context, index);
          } else
            print('favorite');
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
                                      //  _cartProvider.removeItem(context, index);
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
                                      //   _cartProvider.addItem(context, index);
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
                                '${double.parse(item.size?.price ?? "0.0") + (item.isShalwata == 1 ? 20 : 0) + double.parse(item.preparation?.price ?? "0.0") + double.parse(item.cut?.price ?? "0.0")} ${AppLocalizations.of(context)!.tr('sr')}',
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
}
