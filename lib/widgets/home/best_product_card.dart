import "package:auto_size_text/auto_size_text.dart";
import 'package:flutter/material.dart';
import 'package:new_turki/models/best_seller.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/size_config.dart';

class BestProductCard extends StatelessWidget {
  final Data product;

  const BestProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    final bool _isAr = AppLocalizations.of(context)!.locale == Locale('ar');
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
      child: Container(
        color: Colors.transparent,
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
                        color: Colors.transparent,
                        width: SizeConfig.setWidgetWidthWithFactor(
                            0.35, 0.175, 0.175),
                        height: SizeConfig.setWidgetWidthWithFactor(
                            0.35, 0.175, 0.175),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            // child: Image.asset("assets/images/img.png",
                            child: Image.network(
                              '${((product.images?.length ?? 0) > 0) ? product.images![0].imageUrl : "https://turkieshop.com/images/Jk78x2iKpI1608014433.png?431112"}',
                              width: SizeConfig.setWidgetWidthWithFactor(
                                  0.35, 0.175, 0.175),
                              height: SizeConfig.setWidgetWidthWithFactor(
                                  0.35, 0.175, 0.175),
                              fit: BoxFit.cover,
                            )),
                      ),
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
                  //               const BorderRadius.all(Radius.circular(15.0)),
                  //         ),
                  //         child: Padding(
                  //           padding: const EdgeInsets.only(
                  //               bottom: 2.5, right: 5, left: 5, top: 2.5),
                  //           child: Text(
                  //             _isAr
                  //                 ? product.tags![0].nameAr!
                  //                 : product.tags![0].nameEn!,
                  //             textAlign: TextAlign.center,
                  //             style:
                  //                 TextStyle(color: Colors.white, fontSize: 11),
                  //           ),
                  //         ),
                  //       ))
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
                child: AutoSizeText(
                  _isAr ? product.nameAr! : product.nameEn!,
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
                        padding:
                            const EdgeInsets.only(top: 3, left: 5, right: 5),
                        child: Row(
                          children: [
                            AutoSizeText(
                              product.price.toString(),
                              textAlign: TextAlign.start,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                      decoration: product.salePrice! > 0.0
                                          ? TextDecoration.lineThrough
                                          : TextDecoration.none,
                                      fontSize:
                                          product.salePrice! > 0 ? 10 : 12,
                                      fontWeight: FontWeight.bold),
                              minFontSize: product.salePrice! > 0 ? 10 : 12,
                              maxFontSize: product.salePrice! > 0 ? 10 : 12,
                              maxLines: 1,
                            ),
                            AutoSizeText(
                              product.salePrice! == 0.0
                                  ? " ${AppLocalizations.of(context)!.tr('sr')}"
                                  : "",
                              textAlign: TextAlign.start,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                      fontSize: product.salePrice! > 0 ? 8 : 10,
                                      fontWeight: FontWeight.bold),
                              minFontSize: product.salePrice! > 0 ? 8 : 10,
                              maxFontSize: product.salePrice! > 0 ? 8 : 10,
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: product.salePrice! > 0,
                        child: Row(
                          children: [
                            AutoSizeText(
                              product.salePrice!.toString(),
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
                              " ${AppLocalizations.of(context)!.tr('sr')}",
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