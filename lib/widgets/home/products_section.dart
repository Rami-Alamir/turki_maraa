import 'package:flutter/material.dart';
import 'package:new_turki/models/products.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/size_config.dart';

import 'product_card.dart';

class ProductsSection extends StatelessWidget {
  final Products products;

  const ProductsSection({required this.products});

  @override
  Widget build(BuildContext context) {
    final bool _isAr = AppLocalizations.of(context)!.locale == Locale('ar');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: SizeConfig.screenWidth,
          height: 300,
          child: ListView.builder(
              padding: EdgeInsets.all(0),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: ScrollPhysics(),
              itemCount: products.data!.length,
              itemBuilder: (BuildContext ctxt, int index) {
                return Container(
                  width: SizeConfig.screenWidth,
                  color: Colors.red,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: SizeConfig.screenWidth,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  _isAr
                                      ? products.data![index].typeAr!
                                      : products.data![index].typeEn!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(fontSize: 16)),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () => Navigator.pushNamed(
                                        context, '/ProductsList',
                                        arguments: {
                                          "title": _isAr
                                              ? products.data![index].typeAr!
                                              : products.data![index].typeEn!,
                                          "id":
                                              products.data![index].category!.id
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
                        height: 190,
                        child: ListView.builder(
                            padding: EdgeInsets.all(0),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            physics: ScrollPhysics(),
                            itemCount: products.data![index].products!.length,
                            itemBuilder: (BuildContext ctxt, int index2) {
                              return Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    index2 == 0 ? 10 : 3.0, 0, 0, 0),
                                child: ProductCard(
                                    product: products
                                        .data![index].products![index2]),
                              );
                            }),
                      ),
                    ],
                  ),
                );
              }),
        ),
      ],
    );
  }
}
