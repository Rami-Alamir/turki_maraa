import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controllers/discover_provider.dart';
import '../../../models/discover_data.dart';
import '../../../core/utilities/enum/request_status.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../widgets/home/product_card.dart';
import '../../widgets/shared/retry.dart';
import '../../widgets/shared/spinkit_indicator.dart';
import '../../widgets/home/discover_header.dart';
import '../../widgets/shared/primary_app_bar.dart';

class Discover extends StatefulWidget {
  final Data item;

  const Discover({Key? key, required this.item}) : super(key: key);

  @override
  DiscoverState createState() => DiscoverState();
}

class DiscoverState extends State<Discover> {
  @override
  void initState() {
    final DiscoverProvider discoverProvider =
        Provider.of<DiscoverProvider>(context, listen: false);
    discoverProvider.getDiscoverItem(widget.item.id!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final DiscoverProvider discoverProvider =
        Provider.of<DiscoverProvider>(context);
    final bool isAr =
        AppLocalizations.of(context)!.locale == const Locale('ar');
    return Scaffold(
      appBar: PrimaryAppBar(
        title: isAr ? widget.item.titleAr : widget.item.titleEn,
        back: true,
      ),
      body: discoverProvider.requestStatus == RequestStatus.isLoading
          ? const SpinkitIndicator()
          : discoverProvider.requestStatus == RequestStatus.error
              ? Retry(
                  onPressed: () {
                    discoverProvider.getDiscoverItem(widget.item.id!);
                  },
                )
              : RefreshIndicator(
                  color: Theme.of(context).primaryColor,
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  onRefresh: () async {
                    await discoverProvider.getDiscoverItem(widget.item.id!);
                  },
                  child: ListView(
                    children: [
                      Visibility(
                        visible: discoverProvider
                            .discoverItem!.data!.subImage!.isNotEmpty,
                        child: DiscoverHeader(
                            image:
                                discoverProvider.discoverItem!.data!.subImage!,
                            title: isAr
                                ? discoverProvider
                                    .discoverItem!.data!.descriptionAr!
                                : discoverProvider
                                    .discoverItem!.data!.descriptionEn!),
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
                                        ((discoverProvider.discoverItem!.data
                                                ?.products?.length) ??
                                            0);
                                    i++)
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: ProductCard(
                                      isLarge: true,
                                      id: discoverProvider
                                          .discoverItem!.data!.products![i].id!,
                                      image: discoverProvider
                                              .discoverItem!
                                              .data
                                              ?.products![i]
                                              .productImages
                                              ?.first
                                              .imageUrl ??
                                          "https://turkieshop.com/images/Jk78x2iKpI1608014433.png?431112",
                                      nameAr: discoverProvider.discoverItem!
                                          .data!.products![i].nameAr!,
                                      nameEn: discoverProvider.discoverItem!
                                          .data!.products![i].nameEn!,
                                      price: discoverProvider.discoverItem!
                                          .data!.products![i].price!,
                                      salePrice: discoverProvider.discoverItem!
                                          .data!.products![i].salePrice!,
                                      categoryId: discoverProvider.discoverItem!
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
