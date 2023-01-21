import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "package:auto_size_text/auto_size_text.dart";
import '../../../models/product.dart';
import '../../../core/constants/fixed_assets.dart';
import '../../../core/constants/route_constants.dart';
import '../../../core/service/service_locator.dart';
import '../../../core/service/firebase_helper.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/get_strings.dart';
import '../../../core/utilities/size_config.dart';
import '../../../core/utilities/format_helper.dart';
import '../../../controllers/location_provider.dart';

class ProductCard extends StatelessWidget {
  final int? index;
  final List<Tags>? tag;
  final int id;
  final int categoryId;
  final double price;
  final double salePrice;
  final String image;
  final String nameAr;
  final String nameEn;
  final bool isLarge;

  const ProductCard({
    Key? key,
    required this.id,
    required this.categoryId,
    required this.price,
    required this.salePrice,
    required this.image,
    required this.nameAr,
    required this.nameEn,
    this.tag,
    this.isLarge = false,
    this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isAr =
        AppLocalizations.of(context)!.locale == const Locale('ar');
    final bool haveSalePrice = salePrice > 0 && salePrice != price;
    final LocationProvider locationProvider =
        Provider.of<LocationProvider>(context, listen: false);
    String currency = sl<GetStrings>().getCurrency(
        AppLocalizations.of(context)!.locale!.languageCode,
        locationProvider.isoCountryCode!);
    final int factor = (SizeConfig.screenWidth! ~/ 180);
    final double size =
        isLarge ? (SizeConfig.screenWidth! / factor - 10) - (factor * 6) : 136;

    return Container(
      margin: EdgeInsets.all(isLarge ? 5 : 0),
      color: Colors.transparent,
      width: size,
      child: InkWell(
        onTap: () {
          FirebaseHelper().pushAnalyticsEvent(name: "product", value: nameEn);
          Navigator.pushNamed(context, productDetails,
              arguments: <String, dynamic>{"id": id, "categoryId": categoryId});
        },
        splashColor: Colors.transparent,
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: [
                  Container(
                    height: size,
                    color: Colors.transparent,
                    child: Card(
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      child: Container(
                          color: Colors.transparent,
                          width: size,
                          height: size,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: FadeInImage(
                                placeholderFit: BoxFit.contain,
                                image: NetworkImage(image),
                                width: size,
                                height: size,
                                fit: BoxFit.cover,
                                placeholder:
                                    const AssetImage(FixedAssets.placeholder)),
                          )),
                    ),
                  ),
                  (tag?.length ?? 0) == 0
                      ? Container()
                      : Positioned.directional(
                          textDirection: TextDirection.rtl,
                          top: 15,
                          end: 10,
                          child: Container(
                            constraints: const BoxConstraints(minWidth: 40),
                            decoration: BoxDecoration(
                              color: hexToColor(tag!.first.color!),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15.0)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 2.5, right: 5, left: 5, top: 2.5),
                              child: Text(
                                isAr ? tag!.first.nameAr! : tag!.first.nameEn!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ),
                          )),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 5, left: 7.5, right: 7.5),
                constraints: BoxConstraints(
                  maxHeight: SizeConfig.setWidgetHeight(32, 32, 32),
                ),
                child: AutoSizeText(
                  isAr ? nameAr : nameEn,
                  textAlign: TextAlign.start,
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(height: 1.2),
                  minFontSize: 8,
                  maxFontSize: 12,
                  maxLines: 2,
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 3, left: 7.5, right: 7.5),
                  child: Row(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 3, left: 5, right: 5),
                        child: Row(
                          children: [
                            AutoSizeText(
                              sl<FormatHelper>()
                                  .formatDecimalAndRemoveTrailingZeros(price),
                              textAlign: TextAlign.start,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                      decoration: haveSalePrice
                                          ? TextDecoration.lineThrough
                                          : TextDecoration.none,
                                      fontSize: haveSalePrice ? 10 : 12,
                                      fontWeight: FontWeight.bold),
                              minFontSize: haveSalePrice ? 10 : 12,
                              maxFontSize: haveSalePrice ? 10 : 12,
                              maxLines: 1,
                            ),
                            AutoSizeText(
                              !haveSalePrice ? " $currency" : "",
                              textAlign: TextAlign.start,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                      fontSize: haveSalePrice ? 8 : 10,
                                      fontWeight: FontWeight.bold),
                              minFontSize: haveSalePrice ? 8 : 10,
                              maxFontSize: haveSalePrice ? 8 : 10,
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: haveSalePrice,
                        child: Row(
                          children: [
                            AutoSizeText(
                              sl<FormatHelper>()
                                  .formatDecimalAndRemoveTrailingZeros(
                                      salePrice),
                              textAlign: TextAlign.start,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(fontSize: 14),
                              minFontSize: 10,
                              maxFontSize: 12,
                              maxLines: 1,
                            ),
                            AutoSizeText(
                              " $currency",
                              textAlign: TextAlign.start,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                              minFontSize: 10,
                              maxFontSize: 12,
                              maxLines: 1,
                            ),
                          ],
                        ),
                      )
                    ],
                  )),
            ]),
      ),
    );
  }

  /// Construct a color from a hex code string, of the format #RRGGBB.
  Color hexToColor(String code) {
    return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }
}
