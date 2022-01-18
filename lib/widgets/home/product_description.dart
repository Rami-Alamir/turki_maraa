import 'package:flutter/material.dart';
import 'package:new_turki/models/product.dart';
import 'package:new_turki/provider/auth.dart';
import 'package:new_turki/provider/favourite_provider.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:new_turki/utilities/t_u_r_k_i_i_c_o_n_s_icons.dart';
import 'package:provider/provider.dart';
import 'circle_icon.dart';

class ProductDescription extends StatelessWidget {
  final Product product;
  final double price;

  const ProductDescription({required this.product, required this.price});

  Future<void> _createDynamicLink(bool short, String link) async {
    // // setState(() {
    // //   _isCreatingLink = true;
    // // });
    //
    // final DynamicLinkParameters parameters = DynamicLinkParameters(
    //   uriPrefix: "https://almaraa.page.link",
    //   link: Uri.parse("https://almaraa.page.link" + link),
    //   androidParameters: const AndroidParameters(
    //     packageName: 'com.almaraa.new_turki',
    //     minimumVersion: 0,
    //   ),
    // );
    //
    // Uri url;
    // if (short) {
    //   final ShortDynamicLink shortLink =
    //       await FirebaseHelper.dynamicLinks!.buildShortLink(parameters);
    //   url = shortLink.shortUrl;
    // } else {
    //   url = await FirebaseHelper.dynamicLinks!.buildLink(parameters);
    // }
    // print(url.toString());
    // // setState(() {
    // //   _linkMessage = url.toString();
    // //   _isCreatingLink = false;
    // // });
  }

  @override
  Widget build(BuildContext context) {
    final bool _isAr = AppLocalizations.of(context)!.locale == Locale('ar');
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(12.0, 0, 0, 0),
              child: Container(
                width: SizeConfig.screenWidth! - 130,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _isAr
                          ? product.data!.subCategory!.typeAr!
                          : product.data!.subCategory!.typeEn!,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2!
                          .copyWith(fontSize: 14),
                    ),
                    Text(
                      _isAr ? product.data!.nameAr! : product.data!.nameEn!,
                      style: Theme.of(context)
                          .textTheme
                          .headline4!
                          .copyWith(fontSize: 20, height: 1.4),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 15.0, 12.0, 0),
              child: Row(
                children: [
                  CircleIcon(
                      icon: Icons.share,
                      onTap: () async {
                        _createDynamicLink(false, '/About');
                      },
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(8.0, 0, 0, 0)),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(8.0, 0, 0, 0),
                    child: CircleIcon(
                        icon: Icons.favorite_border_outlined,
                        // icon: isFavourite
                        //     ? Icons.favorite
                        //     : Icons.favorite_border_outlined,
                        onTap: () {
                          final favourite = Provider.of<FavouriteProvider>(
                              context,
                              listen: false);
                          final auth =
                              Provider.of<Auth>(context, listen: false);
                          if (auth.isAuth)
                            favourite.addToFavourite(
                                context: context,
                                authorization: "Bearer ${auth.accessToken}",
                                id: '${product.data!.id!}');
                        },
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 0, 0, 0)),
                  ),
                ],
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0, right: 12, left: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 25,
                child: ListView.builder(
                    itemCount: 5,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return Icon(
                        Icons.star,
                        size: 20,
                        color: product.data!.noRating! >= index
                            ? Color.fromRGBO(250, 202, 29, 1)
                            : Theme.of(context).colorScheme.secondaryVariant,
                      );
                    }),
              ),
              // Text(
              //   ' (${product.data!.noRating!}) ',
              //   style: Theme.of(context)
              //       .textTheme
              //       .subtitle2!
              //       .copyWith(fontSize: 14, height: 1.4),
              // ),
            ],
          ),
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(12.0, 12, 4, 12),
              child: Text(
                '${formatDecimal(price)}${AppLocalizations.of(context)!.tr('sr')}',
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(fontSize: 16, height: 1.4),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8),
              child: Text(
                AppLocalizations.of(context)!.tr('vat_included'),
                style: Theme.of(context)
                    .textTheme
                    .subtitle2!
                    .copyWith(fontSize: 12, height: 1.4),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(right: 12.0, left: 12, bottom: 10),
          child: Text(
            _isAr ? product.data!.descriptionAr! : product.data!.descriptionEn!,
            style: Theme.of(context)
                .textTheme
                .subtitle2!
                .copyWith(fontSize: 14, height: 1.5),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _item(
                context: context,
                title: 'weight',
                value: product.data!.weight!,
                size: 20,
                icon: TURKIICONS.weight_1),
            Padding(padding: const EdgeInsets.all(10)),
            _item(
                context: context,
                title: 'calories',
                value: product.data!.calories!,
                size: 40,
                icon: TURKIICONS.calories_1),
          ],
        ),
      ],
    );
  }

  Widget _item(
      {required BuildContext context,
      required String title,
      required IconData icon,
      required String value,
      required double size}) {
    return Visibility(
      visible: value.length > 0,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Theme.of(context).primaryColor.withOpacity(0.2),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    color: Theme.of(context).primaryColor,
                    size: size,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 0.0, 5.0),
                  child: Text(
                    AppLocalizations.of(context)!.tr(title),
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        ?.copyWith(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(8.0, 5.0, 0.0, 0.0),
                  child: Row(
                    children: [
                      Text(
                        value,
                        style: Theme.of(context).textTheme.headline4?.copyWith(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      Visibility(
                        visible: size == 20,
                        child: Text(
                          " " + AppLocalizations.of(context)!.tr('kg'),
                          style: Theme.of(context)
                              .textTheme
                              .headline4
                              ?.copyWith(
                                  fontSize: 12, fontWeight: FontWeight.bold),
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
    );
  }

  formatDecimal(double value) {
    return value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 3);
  }
}
