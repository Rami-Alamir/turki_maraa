import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:new_turki/provider/favourite_provider.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:new_turki/widgets/shared/main_card.dart';
import 'package:new_turki/models/favourite.dart';
import 'package:provider/provider.dart';

class FavouriteCard extends StatelessWidget {
  final Data data;
  final String accessToken;
  final int index;

  const FavouriteCard({
    required this.data,
    required this.accessToken,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final bool _isAr = AppLocalizations.of(context)!.locale == Locale('ar');
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        final _favourite =
            Provider.of<FavouriteProvider>(context, listen: false);
        _favourite.deleteFromFavourite(
            context: context,
            index: index,
            authorization: accessToken,
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
          onTap: () => Navigator.pushNamed(context, '/ProductDetails',
              arguments: data.product!.id!),
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
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      child: Container(
                        color: Colors.transparent,
                        child: FadeInImage.assetNetwork(
                          placeholder: 'assets/images/turki_icon.png',
                          image: data.product!.productImages!.length > 0
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
                    constraints: BoxConstraints(minHeight: 110),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: SizeConfig.screenWidth! - 160,
                              child: AutoSizeText(
                                  _isAr
                                      ? data.product!.nameAr!
                                      : data.product!.nameEn!,
                                  minFontSize: 12,
                                  maxFontSize: 14,
                                  style: Theme.of(context).textTheme.headline4),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 2.0),
                              child: AutoSizeText(
                                  _isAr
                                      ? data.product!.descriptionAr!
                                      : data.product!.descriptionEn!,
                                  style: Theme.of(context).textTheme.subtitle2),
                            ),
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
                                      final _favourite =
                                          Provider.of<FavouriteProvider>(
                                              context,
                                              listen: false);
                                      _favourite.deleteFromFavourite(
                                          context: context,
                                          index: index,
                                          authorization: accessToken,
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
                                    '${data.product!.price} ${AppLocalizations.of(context)!.tr('sr')}',
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
