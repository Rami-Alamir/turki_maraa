import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:provider/provider.dart';
import '../../../models/search_data.dart';
import '../../../core/utilities/format_helper.dart';
import '../../../core/constants/route_constants.dart';
import '../../../core/service/service_locator.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/get_strings.dart';
import '../../../core/utilities/size_config.dart';
import '../../../controllers/location_provider.dart';

class SearchRow extends StatelessWidget {
  final SearchData item;
  const SearchRow({Key? key, required this.item}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final LocationProvider locationProvider =
        Provider.of<LocationProvider>(context, listen: false);
    String currency = sl<GetStrings>().getCurrency(
        AppLocalizations.of(context)!.locale!.languageCode,
        locationProvider.isoCountryCode!);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
      child: InkWell(
        onTap: () {
          Navigator.pushReplacementNamed(context, productDetails,
              arguments: <String, dynamic>{
                "id": item.id,
                "categoryId": item.categoryId
              });
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                  child: SizedBox(
                    width: 60,
                    height: 60,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          color: Colors.transparent,
                          width: 60,
                          height: 60,
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                            child: Container(
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondaryContainer,
                              width: 60,
                              height: 60,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5.0),
                                  child: Image.network(
                                    item.productImages!.first.imageUrl ??
                                        'https://turki.turkieshop.com/images/Jk78x2iKpI1608014433.png?431112',
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                  )),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SizedBox(
                    width: SizeConfig.screenWidth! - 130,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AutoSizeText(
                              AppLocalizations.of(context)!.locale ==
                                      const Locale('ar')
                                  ? item.nameAr!
                                  : item.nameEn!,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4!
                                  .copyWith(fontSize: 12),
                              maxLines: 1,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              sl<FormatHelper>()
                                  .formatDecimalAndRemoveTrailingZeros(
                                      double.parse(item.salePrice!) > 0.0
                                          ? double.parse(item.salePrice!)
                                          : double.parse(item.price!)),
                              textAlign: TextAlign.start,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(fontSize: 14, height: 1.4),
                            ),
                            Text(
                              " $currency",
                              textAlign: TextAlign.start,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(fontSize: 12, height: 1.4),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            Divider(
              color: Theme.of(context)
                  .colorScheme
                  .secondaryContainer
                  .withOpacity(0.3),
            )
          ],
        ),
      ),
    );
  }
}
