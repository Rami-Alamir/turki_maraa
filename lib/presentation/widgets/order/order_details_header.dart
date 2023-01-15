import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controllers/orders_provider.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/size_config.dart';
import '../../../models/order.dart';
import '../../widgets/shared/main_card.dart';
import 'item_column.dart';

class OrderDetailsHeader extends StatelessWidget {
  const OrderDetailsHeader({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final OrdersProvider ordersProvider = Provider.of<OrdersProvider>(context);
    Data order = ordersProvider.order.data!;
    final bool isAr =
        AppLocalizations.of(context)!.locale == const Locale('ar');
    final DateTime date = DateTime.parse(order.createdAt!.substring(0, 19));
    final int timeZoneInHours = DateTime.now().timeZoneOffset.inHours;
    return MainCard(
      height: 160,
      child: Container(
        constraints: const BoxConstraints(minHeight: 120),
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
                        .copyWith(fontSize: 14),
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          width: SizeConfig.screenWidth! - 50,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ItemColumn(
                                    title: 'delivery_date',
                                    value: '${order.deliveryDate}',
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start),
                                ItemColumn(
                                    title: 'delivery_time',
                                    value: isAr
                                        ? '${order.deliveryPeriod?.nameAr}'
                                        : '${order.deliveryPeriod?.nameEn}',
                                    crossAxisAlignment: CrossAxisAlignment.end),
                              ],
                            ),
                          )),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: SizedBox(
                          width: SizeConfig.screenWidth! - 50,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                )
              ],
            ),
            // OrderTracking(statusCode: order.orderState!.code!),
          ],
        ),
      ),
    );
  }
}
