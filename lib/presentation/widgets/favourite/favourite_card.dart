import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import '../../../core/constants/fixed_assets.dart';
import '../../../core/constants/route_constants.dart';
import '../../../core/service/firebase_helper.dart';
import '../../../models/favourite.dart';
import '../../../controllers/favourite_provider.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/size_config.dart';
import '../shared/main_card.dart';

class FavouriteCard extends StatelessWidget {
  final Data data;
  final int index;

  const FavouriteCard({
    Key? key,
    required this.data,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isAr =
        AppLocalizations.of(context)!.locale == const Locale('ar');
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        final FavouriteProvider favourite =
            Provider.of<FavouriteProvider>(context, listen: false);
        favourite.deleteFromFavourite(
            context: context,
            isLoading: false,
            index: index,
            id: data.id!.toString());
      },
      background: Container(
        color: Colors.red,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              const Icon(Icons.delete, color: Colors.white),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: Text(AppLocalizations.of(context)!.tr('remove'),
                    style: const TextStyle(color: Colors.white, fontSize: 12)),
              ),
            ],
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            FirebaseHelper().pushAnalyticsEvent(
                name: "product", value: data.product!.nameEn!);
            Navigator.pushNamed(context, productDetails,
                arguments: <String, dynamic>{
                  "id": data.product!.id!,
                  "categoryId": data.product!.categoryId!
                });
          },
          child: MainCard(
            padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 3),
            height: 125,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      child: Container(
                        color: Colors.transparent,
                        child: FadeInImage.assetNetwork(
                          placeholder: FixedAssets.placeholder,
                          image: data.product!.productImages!.isNotEmpty
                              ? data.product!.productImages![0].imageUrl!
                              : "https://turkieshop.com/images/Jk78x2iKpI1608014433.png?431112",
                          width: 110,
                          height: 110,
                          fit: BoxFit.fill,
                        ),
                      )),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                      10.0, 10.0, 0.0, 0.0),
                  child: Container(
                    width: SizeConfig.screenWidth! - 160,
                    constraints: const BoxConstraints(minHeight: 110),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: SizeConfig.screenWidth! - 160,
                              child: AutoSizeText(
                                  isAr
                                      ? data.product!.nameAr!
                                      : data.product!.nameEn!,
                                  minFontSize: 12,
                                  maxFontSize: 14,
                                  style: Theme.of(context).textTheme.headline4),
                            ),
                            Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                child: ReadMoreText(
                                  isAr
                                      ? data.product!.descriptionAr!
                                      : data.product!.descriptionEn!,
                                  trimLines: 2,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .copyWith(fontSize: 12, height: 1.5),
                                  colorClickableText:
                                      Theme.of(context).primaryColor,
                                  trimMode: TrimMode.Line,
                                  semanticsLabel: "",
                                  delimiter: " ",
                                  trimCollapsedText:
                                      "...${AppLocalizations.of(context)!.tr('show_more')}",
                                  trimExpandedText:
                                      AppLocalizations.of(context)!
                                          .tr('show_less'),
                                  moreStyle: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(
                                          fontSize: 10,
                                          fontWeight: FontWeight.normal),
                                )),
                          ],
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      final FavouriteProvider favourite =
                                          Provider.of<FavouriteProvider>(
                                              context,
                                              listen: false);
                                      favourite.deleteFromFavourite(
                                          context: context,
                                          isLoading: false,
                                          id: data.id!.toString());
                                    },
                                    child: Text(
                                        AppLocalizations.of(context)!
                                            .tr('delete'),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5),
                                  ),
                                  Text(
                                    '${data.product!.price}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1
                                        ?.copyWith(
                                          fontSize: 14,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
