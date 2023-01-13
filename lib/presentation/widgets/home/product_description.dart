import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'circle_icon.dart';
import '../../../core/service/service_locator.dart';
import '../../../core/utilities/format_helper.dart';
import '../../../models/product_details.dart';
import '../../../controllers/favourite_provider.dart';
import '../../../controllers/location_provider.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/get_strings.dart';
import '../../../core/utilities/size_config.dart';

class ProductDescription extends StatelessWidget {
  final ProductDetails product;
  final double price;
  final double salePrice;
  final bool isFavourite;

  const ProductDescription({
    Key? key,
    required this.product,
    required this.price,
    required this.salePrice,
    required this.isFavourite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isAr =
        AppLocalizations.of(context)!.locale == const Locale('ar');
    final LocationProvider locationProvider =
        Provider.of<LocationProvider>(context, listen: false);
    String currency = sl<GetStrings>().getCurrency(
        AppLocalizations.of(context)!.locale!.languageCode,
        locationProvider.isoCountryCode!);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(12.0, 8, 0, 0),
              child: SizedBox(
                width: SizeConfig.screenWidth! - 130,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isAr
                          ? product.data!.subCategory?.typeAr ?? ""
                          : product.data!.subCategory?.typeEn ?? "",
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2!
                          .copyWith(fontSize: 14),
                    ),
                    Text(
                      isAr ? product.data!.nameAr! : product.data!.nameEn!,
                      style: Theme.of(context)
                          .textTheme
                          .headline4!
                          .copyWith(fontSize: 20, height: 1.4),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 15.0, 12.0, 0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(8.0, 0, 0, 0),
                    child: CircleIcon(
                        icon: isFavourite
                            ? Icons.favorite
                            : Icons.favorite_border_outlined,
                        onTap: () {
                          final favourite = Provider.of<FavouriteProvider>(
                              context,
                              listen: false);
                          if (favourite.isAuth) {
                            if (isFavourite) {
                              favourite.deleteFromFavourite(
                                  context: context,
                                  id: favourite
                                      .getFavouriteId(
                                          int.parse('${product.data!.id!}'))
                                      .toString());
                            } else {
                              favourite.addToFavourite(
                                  context: context, id: '${product.data!.id!}');
                            }
                          }
                        },
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 0, 0, 0)),
                  ),
                ],
              ),
            )
          ],
        ),
        Row(
          children: [
            Padding(
                padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 3, left: 5, right: 5),
                      child: Text(
                        sl<FormatHelper>()
                            .formatDecimalAndRemoveTrailingZeros(price),
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            color: salePrice > 0.0 && salePrice < price
                                ? Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .color!
                                    .withOpacity(0.4)
                                : Theme.of(context).textTheme.subtitle1!.color,
                            decorationThickness: 2,
                            decoration: salePrice > 0.0 && salePrice < price
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                            fontSize: salePrice > 0 ? 14 : 16,
                            fontWeight: FontWeight.bold),
                        maxLines: 1,
                      ),
                    ),
                    Visibility(
                      visible: salePrice > 0 && salePrice < price,
                      child: Text(
                        '${sl<FormatHelper>().formatDecimalAndRemoveTrailingZeros(salePrice)} ',
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            fontSize: 16,
                            height: 1.4,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(currency,
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            fontSize: 16,
                            height: 1.4,
                            fontWeight: FontWeight.bold)),
                  ],
                )),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8),
              child: Text(
                AppLocalizations.of(context)!.tr('vat_included'),
                style: Theme.of(context)
                    .textTheme
                    .subtitle2!
                    .copyWith(fontSize: 12, height: 1.4),
              ),
            ),
          ],
        ),
        Visibility(
          visible: isAr
              ? product.data!.descriptionAr!.isNotEmpty
              : product.data!.descriptionEn!.isNotEmpty,
          child: Padding(
              padding: const EdgeInsets.only(right: 15.0, left: 15, bottom: 10),
              child: ReadMoreText(
                isAr
                    ? product.data!.descriptionAr!
                    : product.data!.descriptionEn!,
                trimLines: 2,
                style: Theme.of(context)
                    .textTheme
                    .subtitle2!
                    .copyWith(fontSize: 14, height: 1.5),
                colorClickableText: Theme.of(context).primaryColor,
                trimMode: TrimMode.Line,
                semanticsLabel: "",
                delimiter: " ",
                trimCollapsedText:
                    "...${AppLocalizations.of(context)!.tr('show_more')}",
                trimExpandedText: AppLocalizations.of(context)!.tr('show_less'),
                moreStyle: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(fontSize: 12, fontWeight: FontWeight.normal),
              )),
        ),
      ],
    );
  }

  formatDecimal(double value) {
    return value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 3);
  }
}
