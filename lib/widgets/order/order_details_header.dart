import 'package:flutter/material.dart';
import 'package:new_turki/models/order.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:new_turki/widgets/order/item_column.dart';
import 'package:new_turki/widgets/shared/main_card.dart';
import '../../utilities/convert_days.dart';

class OrderDetailsHeader extends StatelessWidget {
  final Data order;

  const OrderDetailsHeader({required this.order});
  @override
  Widget build(BuildContext context) {
    final bool _isAr = AppLocalizations.of(context)!.locale == Locale('ar');
    final DateTime date = DateTime.parse(order.createdAt!.substring(0, 19));

    final int timeZoneInHours = DateTime.now().timeZoneOffset.inHours;
    return MainCard(
      height: 160,
      // height: 235,
      child: Container(
        constraints: BoxConstraints(minHeight: 120),
        // constraints: BoxConstraints(minHeight: 150),
        width: SizeConfig.screenWidth!,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    '${AppLocalizations.of(context)!.tr("order_id")}: #${order.refNo}',
                    style: Theme.of(context)
                        .textTheme
                        .headline1!
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                      10.0, 10.0, 0.0, 0.0),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            width: SizeConfig.screenWidth! * .9 - 15,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ItemColumn(
                                      title: (order.orderProducts?[0].product
                                                      ?.categoryId ??
                                                  0) !=
                                              34
                                          ? 'delivery_date'
                                          : "day_of_sacrifice",
                                      value: (order.orderProducts?[0].product
                                                      ?.categoryId ??
                                                  0) !=
                                              34
                                          ? '${order.deliveryDate}'
                                          : AppLocalizations.of(context)!.tr(
                                              ConvertDays.convertDay(
                                                  order.deliveryDate!)),
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start),
                                  Visibility(
                                    visible: (order.orderProducts?[0].product
                                                ?.categoryId ??
                                            0) !=
                                        34,
                                    child: ItemColumn(
                                        title: 'delivery_time',
                                        value: _isAr
                                            ? '${order.deliveryPeriod?.nameAr}'
                                            : '${order.deliveryPeriod?.nameEn}',
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end),
                                  ),
                                ],
                              ),
                            )),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Container(
                            width: SizeConfig.screenWidth! * .9 - 15,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ItemColumn(
                                      title: 'order_date',
                                      value: DateTime(
                                              date.year,
                                              date.month,
                                              (date.day),
                                              (date.hour + timeZoneInHours))
                                          .toString()
                                          .substring(0, 10),
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start),
                                  // ItemColumn(
                                  //     title: 'points_earned',
                                  //     value: 'نقاط هنا',
                                  //     crossAxisAlignment:
                                  //         CrossAxisAlignment.end),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            //   OrderTracking(statusCode: order.orderState!.code!),
          ],
        ),
      ),
    );
  }
}
