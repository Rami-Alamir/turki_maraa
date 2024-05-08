import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'discover_card.dart';
import '../../../../controllers/products_provider.dart';
import '../../../../core/utilities/app_localizations.dart';
import '../../../../core/utilities/size_config.dart';

class DiscoverSection extends StatelessWidget {
  const DiscoverSection({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductsProvider productsProvider =
        Provider.of<ProductsProvider>(context);
    return SliverToBoxAdapter(
      child: (productsProvider.discoverData!.data?.length ?? 0) > 0
          ? Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 20.0, left: 20, bottom: 15, top: 15),
                      child: Text(AppLocalizations.of(context)!.tr('discover'),
                          style: Theme.of(context).textTheme.titleSmall),
                    ),
                  ],
                ),
                SizedBox(
                  width: SizeConfig.screenWidth,
                  height: 100,
                  child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: const ScrollPhysics(),
                      itemCount: productsProvider.discoverData!.data!.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        return Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              index == 0 ? 8 : 3.0, 0, 8, 0),
                          child: DiscoverCard(
                            item: productsProvider.discoverData!.data![index],
                          ),
                        );
                      }),
                ),
              ],
            )
          : const SizedBox.shrink(),
    );
  }
}
