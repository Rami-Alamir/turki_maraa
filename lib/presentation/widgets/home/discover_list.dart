import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'product_card.dart';
import '../../../controllers/discover_provider.dart';

class DiscoverList extends StatelessWidget {
  const DiscoverList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DiscoverProvider discoverProvider =
        Provider.of<DiscoverProvider>(context);
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 4.0, 4.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Wrap(
            children: [
              for (int i = 0;
                  i <
                      ((discoverProvider
                              .discoverItem!.data?.products?.length) ??
                          0);
                  i++)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: ProductCard(
                    isLarge: true,
                    id: discoverProvider.discoverItem!.data!.products![i].id!,
                    image: discoverProvider.discoverItem!.data?.products![i]
                            .productImages?.first.imageUrl ??
                        "https://turkieshop.com/images/Jk78x2iKpI1608014433.png?431112",
                    nameAr: discoverProvider
                        .discoverItem!.data!.products![i].nameAr!,
                    nameEn: discoverProvider
                        .discoverItem!.data!.products![i].nameEn!,
                    price: discoverProvider
                        .discoverItem!.data!.products![i].price!,
                    salePrice: discoverProvider
                        .discoverItem!.data!.products![i].salePrice!,
                    categoryId: discoverProvider
                        .discoverItem!.data!.products![i].categoryId!,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
