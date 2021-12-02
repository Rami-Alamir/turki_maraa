import 'package:flutter/material.dart';
import 'package:new_turki/models/order.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:new_turki/widgets/order/item_column.dart';
import 'package:new_turki/widgets/shared/main_card.dart';
import 'order_tracking.dart';

class OrderDetailsHeader extends StatelessWidget {
  final Order order;

  const OrderDetailsHeader({required this.order});
  @override
  Widget build(BuildContext context) {
    return MainCard(
      height: 235,
      child: Container(
        height: 150,
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
                    '${AppLocalizations.of(context)!.tr("order_id")}: #54698',
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
                                      title: 'delivery_date',
                                      value: '10/09/2021',
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start),
                                  ItemColumn(
                                      title: 'delivery_time',
                                      value: 'فترة الظهر',
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end),
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
                                      value: '10/09/2021',
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start),
                                  ItemColumn(
                                      title: 'points_earned',
                                      value: 'فترة الظهر',
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end),
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
            OrderTracking(
              statusCode: order.statusCode,
            ),
          ],
        ),
      ),
    );
  }
}