import 'package:flutter/material.dart';
import '../../../models/discover_data.dart';
import '../../../controllers/products_provider.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../widgets/home/product_card.dart';
import '../../widgets/shared/retry.dart';
import '../../widgets/shared/spinkit_indicator.dart';
import '../../widgets/home/discover_header.dart';
import '../../widgets/shared/primary_app_bar.dart';
import 'package:provider/provider.dart';

class Discover extends StatefulWidget {
  final Data item;

  const Discover({Key? key, required this.item}) : super(key: key);

  @override
  DiscoverState createState() => DiscoverState();
}

class DiscoverState extends State<Discover> {
  @override
  void initState() {
    final ProductsProvider productsProvider =
        Provider.of<ProductsProvider>(context, listen: false);
    productsProvider.getDiscoverItem(widget.item.id!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ProductsProvider productsProvider =
        Provider.of<ProductsProvider>(context);
    final bool isAr =
        AppLocalizations.of(context)!.locale == const Locale('ar');
    return Scaffold(
      appBar: PrimaryAppBar(
        title: isAr ? widget.item.titleAr : widget.item.titleEn,
        back: true,
      ),
      body: productsProvider.discoverIsLoading
          ? const SpinkitIndicator()
          : productsProvider.discoverRetry
              ? Retry(
                  onPressed: () {
                    productsProvider.getDiscoverItem(widget.item.id!);
                  },
                )
              : RefreshIndicator(
                  color: Theme.of(context).primaryColor,
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  onRefresh: () async {
                    await productsProvider.getDiscoverItem(widget.item.id!);
                  },
                  child: ListView(
                    children: [
                      Visibility(
                        visible: productsProvider
                            .discoverItem.data!.subImage!.isNotEmpty,
                        child: DiscoverHeader(
                            image:
                                productsProvider.discoverItem.data!.subImage!,
                            title: isAr
                                ? productsProvider
                                    .discoverItem.data!.descriptionAr!
                                : productsProvider
                                    .discoverItem.data!.descriptionEn!),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            0.0, 4.0, 4.0, 4.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Wrap(
                              children: [
                                for (int i = 0;
                                    i <
                                        ((productsProvider.discoverItem.data
                                                ?.products?.length) ??
                                            0);
                                    i++)
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: ProductCard(
                                      isLarge: true,
                                      id: productsProvider
                                          .discoverItem.data!.products![i].id!,
                                      image: productsProvider
                                              .discoverItem
                                              .data
                                              ?.products![i]
                                              .productImages
                                              ?.first
                                              .imageUrl ??
                                          "https://turkieshop.com/images/Jk78x2iKpI1608014433.png?431112",
                                      nameAr: productsProvider.discoverItem
                                          .data!.products![i].nameAr!,
                                      nameEn: productsProvider.discoverItem
                                          .data!.products![i].nameEn!,
                                      price: productsProvider.discoverItem.data!
                                          .products![i].price!,
                                      salePrice: productsProvider.discoverItem
                                          .data!.products![i].salePrice!,
                                      categoryId: productsProvider.discoverItem
                                          .data!.products![i].categoryId!,
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
    );
  }
}
