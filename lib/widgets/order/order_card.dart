import 'package:flutter/material.dart';
import 'package:new_turki/models/order.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/size_config.dart';

import 'item_column.dart';

class OrderCard extends StatelessWidget {
  final Order order;

  const OrderCard({
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 7.5),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, '/OrderDetails',
            arguments: int.parse(order.id)),
        child: Container(
            height: 250,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.bottomLeft,
                colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).primaryColor.withOpacity(0.78),
                ],
              ),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8.0),
                  topLeft: Radius.circular(8.0),
                  bottomRight: Radius.circular(5.0),
                  bottomLeft: Radius.circular(5.0)),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context)
                      .colorScheme
                      .secondaryVariant
                      .withOpacity(0.15),
                  spreadRadius: 0.5,
                  blurRadius: 11,
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.all(const Radius.circular(8)),
                    child: Container(
                      width: SizeConfig.screenWidth,
                      height: 175,
                      color: Theme.of(context).colorScheme.secondary,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Card(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(11.0)),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(11),
                                        ),
                                        child: Container(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                          child: Image.network(
                                            order.image,
                                            width: 60,
                                            height: 60,
                                            fit: BoxFit.fill,
                                          ),
                                        )),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 2),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                              "${AppLocalizations.of(context)!.tr('order_id')}: ",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline1!
                                                  .copyWith(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                          Text(order.id,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline1!
                                                  .copyWith(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                        ],
                                      ),
                                      order.orderItems.length >= 1
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5.0),
                                              child: Text(
                                                  "${order.orderItems[0].qty} x ${order.orderItems[0].title}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline5!
                                                      .copyWith(
                                                          height: 1,
                                                          fontSize: 14,
                                                          fontWeight: FontWeight
                                                              .normal)),
                                            )
                                          : Container(),
                                      order.orderItems.length >= 2
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5.0),
                                              child: Text(
                                                  "${order.orderItems[1].qty} x ${order.orderItems[1].title}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline5!
                                                      .copyWith(
                                                          height: 1,
                                                          fontSize: 14,
                                                          fontWeight: FontWeight
                                                              .normal)),
                                            )
                                          : Container(),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      10.0, 10.0, 0.0, 0.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width:
                                            SizeConfig.screenWidth! * .9 - 15,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              ItemColumn(
                                                  title: 'payment_method',
                                                  value: order.payment,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start),
                                              ItemColumn(
                                                  title: 'order_status',
                                                  value: order.status,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 20.0),
                                        child: Container(
                                          width:
                                              SizeConfig.screenWidth! * .9 - 15,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                ItemColumn(
                                                    title: 'order_date',
                                                    value: order.date,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start),
                                                ItemColumn(
                                                    title: 'order_type',
                                                    value: order.type,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end),
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
                          ],
                        ),
                      ),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 55,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                    "${AppLocalizations.of(context)!.tr('total')} ",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600)),
                                Text(
                                    "${order.total} ${AppLocalizations.of(context)!.tr('sr')}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal)),
                              ],
                            ),
                            Container(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                      AppLocalizations.of(context)!
                                          .tr('points_earned'),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600)),
                                  Container(
                                    height: 17,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.bottomRight,
                                        end: Alignment.bottomLeft,
                                        colors: [
                                          Colors.green,
                                          Colors.green.withOpacity(0.8),
                                        ],
                                      ), // color: Color.fromRGBO(212, 175, 55, 1),
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.all(
                                          const Radius.circular(15)),
                                      border:
                                          Border.all(color: Colors.transparent),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 3),
                                      child: Text(
                                          "${order.total} ${AppLocalizations.of(context)!.tr('point')}",
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              height: 1.3,
                                              color: Colors.white)),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        height: 25,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          // color: ,
                          shape: BoxShape.rectangle,
                          borderRadius:
                              BorderRadius.all(const Radius.circular(5)),
                          border: Border.all(color: Colors.white, width: 1),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                              AppLocalizations.of(context)!.tr('order_details'),
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.normal,
                                  height: 1.75,
                                  color: Colors.white)),
                        ),
                      ),
                    )
                  ],
                )
              ],
            )),
      ),
    );
  }
}
