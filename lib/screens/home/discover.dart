import 'package:flutter/material.dart';
import 'package:new_turki/models/discover_item.dart';
import 'package:new_turki/provider/home_provider.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:new_turki/widgets/home/discover_header.dart';
import 'package:new_turki/widgets/home/product_card_large.dart';
import 'package:new_turki/widgets/shared/primary_app_bar.dart';
import 'package:new_turki/widgets/shared/retry.dart';
import 'package:new_turki/widgets/shared/spinkit_indicator.dart';
import 'package:provider/provider.dart';

class Discover extends StatefulWidget {
  final DiscoverItem item;

  const Discover({required this.item});

  @override
  _DiscoverState createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover> {
  @override
  void initState() {
    final _homeProvider = Provider.of<HomeProvider>(context, listen: false);
    _homeProvider.getDiscoverList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _homeProvider = Provider.of<HomeProvider>(context);
    final bool _isAr = AppLocalizations.of(context)!.locale == Locale('ar');
    return Scaffold(
      appBar: PrimaryAppBar(
        title: _isAr ? widget.item.nameAr : widget.item.nameEn,
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
                      DiscoverHeader(
                          image: widget.item.image,
                          title: _isAr
                              ? widget.item.descriptionAr
                              : widget.item.descriptionEn),
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
                          itemCount: _homeProvider
                              .productsList.data![0].products!.length,
                          itemBuilder: (BuildContext ctx, index) {
                            return Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  index % 2 == 0 ? 10 : 0,
                                  0,
                                  index % 2 != 0 ? 10 : 00,
                                  0),
                              child: ProductCardLarge(
                                product: _homeProvider
                                    .productsList.data![0].products![index],
                              ),
                            );
                          }),
                    ],
                  ),
                ),
    );
  }
}
