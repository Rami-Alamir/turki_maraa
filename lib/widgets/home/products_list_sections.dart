import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:new_turki/models/products.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/size_config.dart';

import 'product_card.dart';

class ProductsListSections extends StatelessWidget {
  final Products products;

  const ProductsListSections({required this.products});

  @override
  Widget build(BuildContext context) {
    final bool _isAr = AppLocalizations.of(context)!.locale == Locale('ar');
    return Container(
      constraints: BoxConstraints(
          minHeight: SizeConfig.screenHeight!,
          maxWidth: SizeConfig.screenWidth!),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: SizeConfig.screenWidth,
            child: ListView.builder(
                padding: EdgeInsets.all(0),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: const ScrollPhysics(),
                itemCount: products.data!.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  return Visibility(
                    visible: products.data![index].products!.length > 0,
                    child: Container(
                      width: SizeConfig.screenWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: SizeConfig.screenWidth,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: SizeConfig.screenWidth! * 0.66,
                                    child: AutoSizeText(
                                        _isAr
                                            ? products.data![index].typeAr!
                                            : products.data![index].typeEn!,
                                        maxFontSize: 16,
                                        maxLines: 8,
                                        minFontSize: 10,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1),
                                  ),
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () => Navigator.pushNamed(
                                            context, '/ProductsList',
                                            arguments: {
                                              "title": _isAr
                                                  ? products
                                                      .data![index].typeAr!
                                                  : products
                                                      .data![index].typeEn!,
                                              "index": index
                                            }),
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        child: Text(
                                            AppLocalizations.of(context)!
                                                .tr('view_all'),
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1!
                                                .copyWith(fontSize: 10)),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        size: 15,
                                        color: Theme.of(context)
                                            .textTheme
                                            .subtitle1!
                                            .color,
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 200,
                            child: ListView.builder(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 0, 10, 0),
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                physics: const ScrollPhysics(),
                                itemCount:
                                    products.data![index].products!.length,
                                itemBuilder: (BuildContext ctxt, int index2) {
                                  return Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        3.0, 0, 0, 0),
                                    child: ProductCard(
                                        product: products
                                            .data![index].products![index2]),
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
