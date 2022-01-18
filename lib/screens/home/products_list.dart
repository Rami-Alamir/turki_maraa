import 'package:flutter/material.dart';
import 'package:new_turki/provider/home_provider.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:new_turki/widgets/home/product_card_large.dart';
import 'package:new_turki/widgets/shared/primary_app_bar.dart';
import 'package:new_turki/widgets/shared/retry.dart';
import 'package:new_turki/widgets/shared/spinkit_indicator.dart';
import 'package:provider/provider.dart';

class ProductsList extends StatefulWidget {
  final Map<String, dynamic> data;

  const ProductsList({required this.data});

  @override
  _ProductsListState createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  @override
  void initState() {
    final _homeProvider = Provider.of<HomeProvider>(context, listen: false);
    _homeProvider.getDiscoverList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _homeProvider = Provider.of<HomeProvider>(context);
    return Scaffold(
      appBar: PrimaryAppBar(
        title: widget.data['title'],
        back: true,
      ),
      body: _homeProvider.discoverIsLoading
          ? SpinkitIndicator()
          : _homeProvider.discoverRetry
              ? Retry(
                  onPressed: () {
                    _homeProvider.getDiscoverList();
                  },
                )
              : RefreshIndicator(
                  color: Theme.of(context).primaryColor,
                  onRefresh: () async {},
                  child: ListView(
                    children: [
                      GridView.builder(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing:
                                      SizeConfig.screenWidth! - 360,
                                  mainAxisSpacing: 0,
                                  childAspectRatio: 0.85),
                          itemCount: _homeProvider.productsList
                              .data![widget.data['index']].products!.length,
                          itemBuilder: (BuildContext ctx, index) {
                            return Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  index % 2 == 0 ? 10 : 0,
                                  0,
                                  index % 2 != 0 ? 10 : 00,
                                  0),
                              child: ProductCardLarge(
                                product: _homeProvider
                                    .productsList
                                    .data![widget.data['index']]
                                    .products![index],
                              ),
                            );
                          }),
                    ],
                  ),
                ),
    );
  }
}
