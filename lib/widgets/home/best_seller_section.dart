import 'package:flutter/material.dart';
import 'package:new_turki/models/best_seller.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'best_product_card.dart';

class BestSellerSection extends StatelessWidget {
  final BestSeller products;

  const BestSellerSection({required this.products});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: SizeConfig.screenWidth,
          child: Visibility(
            visible: (products.data?.length ?? 0) > 0,
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(AppLocalizations.of(context)!.tr('most_wanted'),
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(fontSize: 16)),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 200,
                    child: ListView.builder(
                        padding: EdgeInsets.all(0),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        physics: const ScrollPhysics(),
                        itemCount: products.data!.length,
                        itemBuilder: (BuildContext ctxt, int index) {
                          return Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                index == 0 ? 10 : 3.0, 0, 0, 0),
                            child:
                                BestProductCard(product: products.data![index]),
                          );
                        }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
