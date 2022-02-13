import "package:auto_size_text/auto_size_text.dart";
import 'package:flutter/material.dart';
import 'package:new_turki/provider/address_provider.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/get_strings.dart';
import 'package:provider/provider.dart';

class ProductCardLarge extends StatelessWidget {
  final int id;
  final String image;
  final String nameAr;
  final String nameEn;
  final double price;
  final double salePrice;
  const ProductCardLarge(
      {required this.image,
      required this.id,
      required this.nameAr,
      required this.nameEn,
      required this.price,
      required this.salePrice});

  @override
  Widget build(BuildContext context) {
    final bool _isAr = AppLocalizations.of(context)!.locale == Locale('ar');
    final _addressProvider =
        Provider.of<AddressProvider>(context, listen: false);
    String _currency = GetStrings().getCurrency(
        AppLocalizations.of(context)!.locale!.languageCode,
        _addressProvider.isoCountryCode);
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () =>
          Navigator.pushNamed(context, "/ProductDetails", arguments: id),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Stack(
            children: [
              Container(
                color: Colors.transparent,
                height: 160,
                child: Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  child: SizedBox(
                      width: 160,
                      height: 160,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: FadeInImage.assetNetwork(
                          width: 160,
                          height: 160,
                          fit: BoxFit.cover,
                          placeholder: 'assets/images/turki_gold.png',
                          image: image,
                        ),
                      )),
                ),
              ),
              // if ((product.tags?.length ?? 0) > 0)
              //   Positioned.directional(
              //       textDirection: TextDirection.rtl,
              //       top: 15,
              //       end: 10,
              //       child: Container(
              //         constraints: const BoxConstraints(minWidth: 40),
              //         decoration: BoxDecoration(
              //           color: hexToColor(product.tags![0].color!),
              //           borderRadius:
              //               const BorderRadius.all(Radius.circular(20.0)),
              //         ),
              //         child: Padding(
              //           padding: const EdgeInsets.only(
              //               bottom: 2.5, right: 5, left: 5, top: 2.5),
              //           child: Text(
              //             _isAr
              //                 ? product.tags![0].nameAr!
              //                 : product.tags![0].nameEn!,
              //             textAlign: TextAlign.center,
              //             style: TextStyle(color: Colors.white, fontSize: 11),
              //           ),
              //         ),
              //       ))
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
            child: AutoSizeText(
              _isAr ? nameAr : nameEn,
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.headline4,
              minFontSize: 14,
              maxFontSize: 14,
              maxLines: 1,
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 3, left: 5, right: 5),
                    child: Row(
                      children: [
                        AutoSizeText(
                          price.toString(),
                          textAlign: TextAlign.start,
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(
                                  decoration: salePrice > 0.0
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                  fontSize: salePrice > 0 ? 10 : 14,
                                  fontWeight: FontWeight.bold),
                          minFontSize: salePrice > 0 ? 12 : 14,
                          maxFontSize: salePrice > 0 ? 12 : 14,
                          maxLines: 1,
                        ),
                        AutoSizeText(
                          " $_currency",
                          textAlign: TextAlign.start,
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(
                                  fontSize: salePrice > 0 ? 8 : 12,
                                  fontWeight: FontWeight.bold),
                          minFontSize: salePrice > 0 ? 8 : 12,
                          maxFontSize: salePrice > 0 ? 8 : 12,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: salePrice > 0,
                    child: Row(
                      children: [
                        AutoSizeText(
                          salePrice.toString(),
                          textAlign: TextAlign.start,
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(fontSize: 14),
                          minFontSize: 12,
                          maxFontSize: 14,
                          maxLines: 1,
                        ),
                        AutoSizeText(
                          " $_currency",
                          textAlign: TextAlign.start,
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(
                                  fontSize: 10, fontWeight: FontWeight.bold),
                          minFontSize: 12,
                          maxFontSize: 14,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }

  /// Construct a color from a hex code string, of the format #RRGGBB.
  Color hexToColor(String code) {
    return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }
}
