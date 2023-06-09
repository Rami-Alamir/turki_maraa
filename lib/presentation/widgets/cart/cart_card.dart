import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../shared/main_card.dart';
import '../shared/rounded_rectangle_button.dart';
import '../../../controllers/cart_provider.dart';
import '../../../controllers/favourite_provider.dart';
import '../../../controllers/location_provider.dart';
import '../../../core/constants/route_constants.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/service/firebase_helper.dart';
import '../../../core/service/service_locator.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/calculate_helper.dart';
import '../../../core/utilities/format_helper.dart';
import '../../../core/utilities/get_strings.dart';
import '../../../core/utilities/show_snack_bar.dart';
import '../../../core/utilities/size_config.dart';
import '../../../models/cart_data.dart';

class CartCard extends StatelessWidget {
  final ItemData item;
  final int index;
  const CartCard({
    Key? key,
    required this.item,
    required this.index,
  }) : super(key: key);
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
        FirebaseHelper()
            .pushAnalyticsEvent(name: "product", value: item.product!.nameEn!);
        Navigator.pushNamed(context, productDetails,
            arguments: <String, dynamic>{
              "id": item.productId,
              "categoryId": 0
            });
      },
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
                  productName: item.product!.nameAr!,
                  id: '${item.product!.id!}');
              delete(context, cartProvider);
            }
          },
          background: Container(
            color: AppColors.green,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  const Icon(Icons.favorite, color: AppColors.white),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                    child: Text(
                        AppLocalizations.of(context)!.tr('add_to_favorites'),
                        style: const TextStyle(
                            color: AppColors.white, fontSize: 12)),
                  ),
                ],
              ),
            ),
          ),
          secondaryBackground: Container(
            color: AppColors.red,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Icon(Icons.delete, color: AppColors.white),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                    child: Text(AppLocalizations.of(context)!.tr('remove'),
                        style: const TextStyle(
                            color: AppColors.white, fontSize: 12)),
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
                          item.product!.productImages!.isNotEmpty
                              ? item.product!.productImages!.first.imageUrl!
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
                                      ? item.product!.nameAr!
                                      : item.product!.nameEn!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayLarge!
                                      .copyWith(
                                        fontWeight: FontWeight.w700,
                                      )),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5.0),
                                child: Text(
                                    "${language ? "${item.size?.nameAr ?? ""} ${item.cut?.nameAr ?? ""}"
                                        " ${item.preparation?.nameAr ?? ""} ${item.isShalwata == 1 ? "مع شلوطة" : ""}" : "${item.size?.nameEn ?? ""} ${item.cut?.nameEn ?? ""} "
                                        "${item.preparation?.nameEn ?? ""} ${item.isShalwata == 1 ? "with shalwata" : ""}"}${item.isLyh! ? AppLocalizations.of(context)!.tr('without_tail_fat') : ""} ${item.isRas! ? AppLocalizations.of(context)!.tr('without_head') : ""} ${item.isKwar3! ? AppLocalizations.of(context)!.tr('without_trotters') : ""} ${item.isKarashah! ? AppLocalizations.of(context)!.tr('without_tripe') : ""} ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall),
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
                                      if (item.quantity! <= 1) {
                                        delete(context, cartProvider);
                                      } else {
                                        FirebaseHelper().pushAnalyticsEvent(
                                            name: 'cart_card_action',
                                            value: 'subtract');
                                        update(context, cartProvider,
                                            (item.quantity! - 1).toString());
                                      }
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
                                        .displayLarge!
                                        .copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                  ),
                                  RoundedRectangleButton(
                                    onPressed: () {
                                      FirebaseHelper().pushAnalyticsEvent(
                                          name: 'cart_card_action',
                                          value: 'add');
                                      update(context, cartProvider,
                                          (item.quantity! + 1).toString());
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
                                  "${sl<FormatHelper>().formatDecimalAndRemoveTrailingZeros((sl<CalculateHelper>().getCartItemTotalPrice(cartProvider.cartData!.data!.cart!.data![index]) * item.quantity!))} $currency",
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium!
                                      .copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700)),
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
      productId: item.id.toString(),
    );
    if (context.mounted) {
      showErrorMessage(context, status);
    }
  }

  Future<void> update(
      BuildContext context, CartProvider cartProvider, String quantity) async {
    final status = await cartProvider.updateCartItem(
      context: context,
      productId: item.id.toString(),
      quantity: quantity,
    );
    if (context.mounted) {
      showErrorMessage(context, status);
    }
  }

  // used to hide indicator dialog and show snack bar with error message
  void showErrorMessage(BuildContext context, bool status) {
    if (context.mounted) {
      Navigator.of(context, rootNavigator: true).pop();
      if (!status) {
        sl<ShowSnackBar>().show(context, "unexpected_error");
      }
    }
  }
}
