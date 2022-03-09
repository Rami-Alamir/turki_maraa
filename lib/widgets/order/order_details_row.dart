import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:new_turki/models/order.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/size_config.dart';

class OrderDetailsRow extends StatelessWidget {
  final String currency;
  final OrderProducts item;
  const OrderDetailsRow({required this.item, required this.currency});
  @override
  Widget build(BuildContext context) {
    final _isAr = AppLocalizations.of(context)!.locale == Locale('ar');
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
      child: InkWell(
        onTap: () {}
        // =>
        //     Navigator.pushNamed(context, '/ProductDetails', arguments: item.id)
        ,
        child: Container(
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
                            item.product!.productImages!.length > 0
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
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    AutoSizeText(
                      "${item.quantity} x ${_isAr ? item.product!.nameAr : item.product!.nameEn}",
                      style: Theme.of(context)
                          .textTheme
                          .headline1!
                          .copyWith(fontSize: 14),
                      maxLines: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 3.0),
                      child: Container(
                        width: SizeConfig.screenWidth! * .6,
                        child: AutoSizeText(
                          _isAr
                              ? "${item.size?.nameAr ?? ""} ${item.cut?.nameAr ?? ""} ${item.preparation?.nameAr ?? ""} ${item.shalwata?.nameAr ?? ""}"
                              : "${item.size?.nameEn ?? ""} ${item.cut?.nameEn ?? ""} ${item.preparation?.nameEn ?? ""} ${item.shalwata?.nameEn ?? ""}",
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(
                                  fontSize: 12, fontWeight: FontWeight.w400),
                          maxLines: 2,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Container(
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
