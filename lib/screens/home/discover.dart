import 'package:flutter/material.dart';
import 'package:new_turki/models/discover_data.dart';
import 'package:new_turki/provider/products_provider.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:new_turki/widgets/home/discover_header.dart';
import 'package:new_turki/widgets/home/product_card_large.dart';
import 'package:new_turki/widgets/shared/primary_app_bar.dart';
import 'package:new_turki/widgets/shared/retry.dart';
import 'package:new_turki/widgets/shared/spinkit_indicator.dart';
import 'package:provider/provider.dart';

class Discover extends StatefulWidget {
  final Data item;

  const Discover({required this.item});

  @override
  _DiscoverState createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover> {
  @override
  void initState() {
    final _productsProvider =
        Provider.of<ProductsProvider>(context, listen: false);
    _productsProvider.getDiscoverItem(widget.item.id!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _productsProvider = Provider.of<ProductsProvider>(context);
    final bool _isAr = AppLocalizations.of(context)!.locale == Locale('ar');
    return Scaffold(
      appBar: PrimaryAppBar(
        title: _isAr ? widget.item.titleAr : widget.item.titleEn,
        back: true,
      ),
      body: _productsProvider.discoverIsLoading
          ? SpinkitIndicator()
          : _productsProvider.discoverRetry
              ? Retry(
                  onPressed: () {
                    _productsProvider.getDiscoverItem(widget.item.id!);
                  },
                )
              : RefreshIndicator(
                  color: Theme.of(context).primaryColor,
                  onRefresh: () async {
                    await _productsProvider.getDiscoverItem(widget.item.id!);
                  },
                  child: ListView(
                    children: [
                      DiscoverHeader(
                          image: _productsProvider.discoverItem.data!.subImage!,
                          title: _isAr
                              ? _productsProvider
                                  .discoverItem.data!.descriptionAr!
                              : _productsProvider
                                  .discoverItem.data!.descriptionEn!),
                      GridView.builder(
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing:
                                      SizeConfig.screenWidth! - 360,
                                  mainAxisSpacing: 0,
                                  childAspectRatio: 0.85),
                          itemCount: _productsProvider
                                  .discoverItem.data?.products?.length ??
                              0,
                          itemBuilder: (BuildContext ctx, index) {
                            return Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  index % 2 == 0 ? 10 : 0,
                                  0,
                                  index % 2 != 0 ? 10 : 00,
                                  0),
                              child: ProductCardLarge(
                                id: _productsProvider
                                    .discoverItem.data!.products![index].id!,
                                image: _productsProvider
                                        .discoverItem
                                        .data
                                        ?.products![index]
                                        .productImages
                                        ?.first
                                        .imageUrl ??
                                    "https://turkieshop.com/images/Jk78x2iKpI1608014433.png?431112",
                                nameAr: _productsProvider.discoverItem.data!
                                    .products![index].nameAr!,
                                nameEn: _productsProvider.discoverItem.data!
                                    .products![index].nameEn!,
                                price: _productsProvider
                                    .discoverItem.data!.products![index].price!,
                                salePrice: _productsProvider.discoverItem.data!
                                    .products![index].salePrice!,
                              ),
                            );
                          }),
                    ],
                  ),
                ),
    );
  }
}
