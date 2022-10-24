import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../../../core/constants/route_constants.dart';
import '../../../models/order.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/size_config.dart';
import '../../../core/service/firebase_helper.dart';

class OrderDetailsRow extends StatelessWidget {
  final String currency;
  final OrderProducts item;
  const OrderDetailsRow({Key? key, required this.item, required this.currency})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final isAr = AppLocalizations.of(context)!.locale == const Locale('ar');
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
      child: InkWell(
        onTap: () {
          FirebaseHelper().pushAnalyticsEvent(
              name: "product", value: item.product!.nameEn!);
          Navigator.pushNamed(context, productDetails,
              arguments: <String, dynamic>{
                "id": item.product!.id!,
                "categoryId": item.product!.categoryId,
              });
        },
        child: SizedBox(
          width: SizeConfig.screenWidth!,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                color: Colors.transparent,
                width: 60,
                height: 60,
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  child: SizedBox(
                    width: 60,
                    height: 60,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: Container(
                          color: Theme.of(context).colorScheme.secondary,
                          child: Image.network(
                            item.product!.productImages!.isNotEmpty
                                ? item.product!.productImages!.first.imageUrl!
                                : "https://turkieshop.com/images/Jk78x2iKpI1608014433.png?431112",
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        )),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    AutoSizeText(
                      "${item.quantity} x ${isAr ? item.product!.nameAr : item.product!.nameEn}",
                      style: Theme.of(context)
                          .textTheme
                          .headline1!
                          .copyWith(fontSize: 14),
                      maxLines: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 3.0),
                      child: SizedBox(
                        width: SizeConfig.screenWidth! * .6,
                        child: AutoSizeText(
                          "${isAr ? "${item.size?.nameAr ?? ""} ${item.cut?.nameAr ?? ""} ${item.preparation?.nameAr ?? ""} ${item.shalwata?.nameAr ?? ""}" : "${item.size?.nameEn ?? ""} ${item.cut?.nameEn ?? ""} ${item.preparation?.nameEn ?? ""} ${item.shalwata?.nameEn ?? ""}"}${item.isLyh! ? AppLocalizations.of(context)!.tr('without_tail_fat') : ""} ${item.isRas! ? AppLocalizations.of(context)!.tr('without_head') : ""} ${item.isKwar3! ? AppLocalizations.of(context)!.tr('without_trotters') : ""} ${item.isKarashah! ? AppLocalizations.of(context)!.tr('without_tripe') : ""} ",
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(
                                  fontSize: 12, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: SizedBox(
                        width: SizeConfig.screenWidth! * .64,
                        child: AutoSizeText(
                          '${item.totalPrice!} $currency',
                          textAlign: TextAlign.end,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(
                                  fontSize: 12,
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w600),
                          maxLines: 2,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
