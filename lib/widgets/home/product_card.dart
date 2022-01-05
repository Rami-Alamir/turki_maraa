import "package:auto_size_text/auto_size_text.dart";
import 'package:flutter/material.dart';
import 'package:new_turki/models/products.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/size_config.dart';

class ProductCard extends StatelessWidget {
  final ProductData product;

  const ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    final bool _isAr = AppLocalizations.of(context)!.locale == Locale('ar');
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
      child: SizedBox(
        width: SizeConfig.setWidgetWidthWithFactor(0.35, 0.175, 0.175),
        height: SizeConfig.setWidgetWidthWithFactor(0.35, 0.175, 0.175),
        child: InkWell(
          onTap: () => Navigator.pushNamed(context, "/ProductDetails",
              arguments: product.id),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: [
                  Container(
                    color: Colors.transparent,
                    height:
                        SizeConfig.setWidgetWidthWithFactor(0.35, 0.175, 0.175),
                    child: Card(
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      child: Container(
                        color: Theme.of(context).colorScheme.secondary,
                        width: SizeConfig.setWidgetWidthWithFactor(
                            0.35, 0.175, 0.175),
                        height: SizeConfig.setWidgetWidthWithFactor(
                            0.35, 0.175, 0.175),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Image.network(
                              '${(product.productImages!.length > 0) ? product.productImages![0].imageUrl : "https://turkieshop.com/images/Jk78x2iKpI1608014433.png?431112"}',
                              width: SizeConfig.setWidgetWidthWithFactor(
                                  0.35, 0.175, 0.175),
                              height: SizeConfig.setWidgetWidthWithFactor(
                                  0.35, 0.175, 0.175),
                              fit: BoxFit.cover,
                            )),
                      ),
                    ),
                  ),
                  // Visibility(
                  //   visible: product.tagColor != null,
                  //   child: Positioned.directional(
                  //       textDirection: TextDirection.rtl,
                  //       top: 15,
                  //       end: 10,
                  //       child: Container(
                  //         constraints: const BoxConstraints(minWidth: 40),
                  //         decoration: BoxDecoration(
                  //           color: hexToColor(product.tagColor!),
                  //           borderRadius:
                  //               const BorderRadius.all(Radius.circular(20.0)),
                  //         ),
                  //         child: Padding(
                  //           padding: const EdgeInsets.only(
                  //               bottom: 1.0, right: 10, left: 10),
                  //           child: Text(
                  //             _isAr ? product.tagTitleAr! : product.tagTitleEn!,
                  //             textAlign: TextAlign.center,
                  //             style:
                  //                 TextStyle(color: Colors.white, fontSize: 14),
                  //           ),
                  //         ),
                  //       )),
                  // )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
                child: AutoSizeText(
                  _isAr ? product.nameAr! : product.nameEn!,
                  textAlign: TextAlign.center,
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
                      Visibility(
                        visible: product.discount! > 0,
                        child: Padding(
                          padding:
                              const EdgeInsets.only(top: 3, left: 5, right: 5),
                          child: Row(
                            children: [
                              AutoSizeText(
                                product.price.toString(),
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(
                                        decoration: product.discount! > 0.0
                                            ? TextDecoration.lineThrough
                                            : TextDecoration.none,
                                        fontSize:
                                            product.discount! > 0 ? 10 : 14,
                                        fontWeight: FontWeight.w500),
                                minFontSize: product.discount! > 0 ? 12 : 14,
                                maxFontSize: product.discount! > 0 ? 12 : 14,
                                maxLines: 1,
                              ),
                              AutoSizeText(
                                " ${AppLocalizations.of(context)!.tr('sr')}",
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(
                                        fontSize:
                                            product.discount! > 0 ? 8 : 12,
                                        fontWeight: FontWeight.w500),
                                minFontSize: product.discount! > 0 ? 8 : 12,
                                maxFontSize: product.discount! > 0 ? 8 : 12,
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          AutoSizeText(
                            (product.price! -
                                    (product.price! * product.discount! / 100))
                                .toString(),
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(fontSize: 14),
                            minFontSize: 12,
                            maxFontSize: 14,
                            maxLines: 1,
                          ),
                          AutoSizeText(
                            " ${AppLocalizations.of(context)!.tr('sr')}",
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(
                                    fontSize: 10,
                                    fontWeight: FontWeight.normal),
                            minFontSize: 12,
                            maxFontSize: 14,
                            maxLines: 1,
                          ),
                        ],
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  /// Construct a color from a hex code string, of the format #RRGGBB.
  Color hexToColor(String code) {
    return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }
}