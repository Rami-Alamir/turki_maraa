import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controllers/cart_provider.dart';
import '../../../controllers/favourite_provider.dart';
import '../../../controllers/location_provider.dart';
import '../../../core/constants/route_constants.dart';
import '../../../core/service/firebase_helper.dart';
import '../../../core/service/service_locator.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/calculate_helper.dart';
import '../../../core/utilities/format_helper.dart';
import '../../../core/utilities/get_strings.dart';
import '../../../core/utilities/show_snack_bar.dart';
import '../../../core/utilities/size_config.dart';
import '../../../models/cart_data.dart';
import '../shared/main_card.dart';
import '../shared/rounded_rectangle_button.dart';

class CartCard extends StatefulWidget {
  final ItemData item;
  final int index;
  const CartCard({
    Key? key,
    required this.item,
    required this.index,
  }) : super(key: key);
  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  @override
  Widget build(BuildContext context) {
    final bool language =
        AppLocalizations.of(context)!.locale == const Locale('ar');
    final CartProvider cartProvider =
        Provider.of<CartProvider>(context, listen: false);
    final LocationProvider locationProvider =
        Provider.of<LocationProvider>(context, listen: false);
    String currency = sl<GetStrings>().getCurrency(
        AppLocalizations.of(context)!.locale!.languageCode,
        locationProvider.isoCountryCode!);
    return InkWell(
      onTap: () {
        FirebaseHelper().pushAnalyticsEvent(
            name: "product", value: widget.item.product!.nameEn!);
        Navigator.pushNamed(context, productDetails,
            arguments: <String, dynamic>{
              "id": widget.item.productId,
              "categoryId": 0
            });
      },
      splashColor: Colors.transparent,
      child: SizedBox(
        width: SizeConfig.screenWidth,
        child: Dismissible(
          key: UniqueKey(),
          onDismissed: (direction) {
            if (direction == DismissDirection.endToStart) {
              delete(context, cartProvider);
            } else {
              FirebaseHelper().pushAnalyticsEvent(
                  name: 'cart_card_action', value: 'add To Favourite');
              final FavouriteProvider favourite =
                  Provider.of<FavouriteProvider>(context, listen: false);
              favourite.addToFavourite(
                  context: context,
                  withDialog: false,
                  productName: widget.item.product!.nameAr!,
                  id: '${widget.item.product!.id!}');
              delete(context, cartProvider);
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
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
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
                          widget.item.product!.productImages!.isNotEmpty
                              ? widget
                                  .item.product!.productImages!.first.imageUrl!
                              : "https://turkieshop.com/images/Jk78x2iKpI1608014433.png?431112",
                          width: SizeConfig.setWidgetWidth(100, 135, 135),
                          height: SizeConfig.setWidgetHeight(100, 135, 135),
                          fit: BoxFit.cover,
                        )),
                  ),
                  Container(
                    constraints: BoxConstraints(
                        minHeight: SizeConfig.setWidgetWidth(100, 135, 135)),
                    child: Container(
                      margin: const EdgeInsetsDirectional.fromSTEB(
                          10.0, 5.0, 0.0, 0.0),
                      width: SizeConfig.screenWidth! -
                          SizeConfig.setWidgetWidth(158, 195, 185),
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
                                  language
                                      ? widget.item.product!.nameAr!
                                      : widget.item.product!.nameEn!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1!
                                      .copyWith(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14)),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5.0),
                                child: Text(
                                    "${language ? "${widget.item.size?.nameAr ?? ""} ${widget.item.cut?.nameAr ?? ""}"
                                        " ${widget.item.preparation?.nameAr ?? ""} ${widget.item.isShalwata == 1 ? "مع شلوطة" : ""}" : "${widget.item.size?.nameEn ?? ""} ${widget.item.cut?.nameEn ?? ""} "
                                        "${widget.item.preparation?.nameEn ?? ""} ${widget.item.isShalwata == 1 ? "with shalwata" : ""}"}${widget.item.isLyh! ? AppLocalizations.of(context)!.tr('without_tail_fat') : ""} ${widget.item.isRas! ? AppLocalizations.of(context)!.tr('without_head') : ""} ${widget.item.isKwar3! ? AppLocalizations.of(context)!.tr('without_trotters') : ""} ${widget.item.isKarashah! ? AppLocalizations.of(context)!.tr('without_tripe') : ""} ",
                                    style:
                                        Theme.of(context).textTheme.headline5),
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
                                      if (widget.item.quantity! <= 1) {
                                        delete(context, cartProvider);
                                      } else {
                                        FirebaseHelper().pushAnalyticsEvent(
                                            name: 'cart_card_action',
                                            value: 'subtract');
                                        update(
                                            context,
                                            cartProvider,
                                            (widget.item.quantity! - 1)
                                                .toString());
                                      }
                                    },
                                    width: 30,
                                    height: 30,
                                    fontSize: 22,
                                    title: '-',
                                  ),
                                  Text(
                                    widget.item.quantity.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1!
                                        .copyWith(fontSize: 16),
                                  ),
                                  RoundedRectangleButton(
                                    onPressed: () {
                                      FirebaseHelper().pushAnalyticsEvent(
                                          name: 'cart_card_action',
                                          value: 'add');
                                      update(
                                          context,
                                          cartProvider,
                                          (widget.item.quantity! + 1)
                                              .toString());
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
                                  "${sl<FormatHelper>().formatDecimalAndRemoveTrailingZeros((sl<CalculateHelper>().getCartItemTotalPrice(cartProvider.cartData!.data!.cart!.data![widget.index]) * widget.item.quantity!))} $currency",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1!
                                      .copyWith(fontSize: 14)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> delete(BuildContext context, CartProvider cartProvider) async {
    FirebaseHelper()
        .pushAnalyticsEvent(name: 'cart_card_action', value: 'delete');
    final status = await cartProvider.deleteCartItem(
      context: context,
      productId: widget.item.id.toString(),
    );
    showErrorMessage(status);
  }

  Future<void> update(
      BuildContext context, CartProvider cartProvider, String quantity) async {
    final status = await cartProvider.updateCartItem(
      context: context,
      productId: widget.item.id.toString(),
      quantity: quantity,
    );
    showErrorMessage(status);
  }

  // used to hide indicator dialog and show snack bar with error message
  void showErrorMessage(bool status) {
    if (!mounted) return;
    Navigator.of(context, rootNavigator: true).pop();
    if (!status) {
      sl<ShowSnackBar>().show(context, "unexpected_error");
    }
  }
}
