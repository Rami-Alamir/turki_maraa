import 'package:flutter/material.dart';
import '../../../core/constants/route_constants.dart';
import '../../../core/service/service_locator.dart';
import '../../../models/orders_data.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/get_strings.dart';
import '../../../core/utilities/size_config.dart';
import 'item_column.dart';

class OrderCard extends StatelessWidget {
  final Data order;

  const OrderCard({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isAr = AppLocalizations.of(context)!.locale == const Locale('ar');
    final DateTime date = DateTime.parse(order.createdAt!.substring(0, 19));
    final int timeZoneInHours = DateTime.now().timeZoneOffset.inHours;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 7.5),
      child: InkWell(
        onTap: () =>
            Navigator.pushNamed(context, orderDetails, arguments: order.refNo),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Container(
            constraints: const BoxConstraints(minHeight: 250),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.bottomLeft,
                colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).primaryColor.withOpacity(0.78),
                ],
              ),
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(8.0),
                  topLeft: Radius.circular(8.0),
                  bottomRight: Radius.circular(5.0),
                  bottomLeft: Radius.circular(5.0)),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context)
                      .colorScheme
                      .secondaryContainer
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
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    child: Container(
                      width: SizeConfig.screenWidth,
                      constraints: const BoxConstraints(minHeight: 175),
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
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(11),
                                        ),
                                        child: Container(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                          child: Image.network(
                                            (order.orderProducts?.length ?? 0) >
                                                    0
                                                ? order
                                                        .orderProducts!
                                                        .first
                                                        .product!
                                                        .productImages!
                                                        .isNotEmpty
                                                    ? order
                                                        .orderProducts!
                                                        .first
                                                        .product!
                                                        .productImages!
                                                        .first
                                                        .imageUrl!
                                                    : "https://turkieshop.com/images/Jk78x2iKpI1608014433.png?431112"
                                                : "https://turkieshop.com/images/Jk78x2iKpI1608014433.png?431112",
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
                                          Text(order.refNo!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline1!
                                                  .copyWith(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                        ],
                                      ),
                                      SizedBox(
                                        width: SizeConfig.screenWidth! / 1.5,
                                        child: ListView.builder(
                                            padding: EdgeInsets.zero,
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: (order.orderProducts
                                                            ?.length ??
                                                        0) >
                                                    2
                                                ? 2
                                                : order.orderProducts?.length,
                                            itemBuilder:
                                                (BuildContext ctxt, int index) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5.0),
                                                child: Text(
                                                    "${order.orderProducts![index].quantity} x ${isAr ? order.products![index].nameAr : order.products![index].nameEn}",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline5!
                                                        .copyWith(
                                                            height: 1,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal)),
                                              );
                                            }),
                                      ),
                                      // order.products!.length >= 1
                                      //     ? Padding(
                                      //         padding:
                                      //             const EdgeInsets.symmetric(
                                      //                 vertical: 5.0),
                                      //         child: Text(
                                      //             "qty x ${_isAr ? order.products![0].nameAr : order.products![0].nameEn}",
                                      //             style: Theme.of(context)
                                      //                 .textTheme
                                      //                 .headline5!
                                      //                 .copyWith(
                                      //                     height: 1,
                                      //                     fontSize: 14,
                                      //                     fontWeight: FontWeight
                                      //                         .normal)),
                                      //       )
                                      //     : Container(),
                                      // order.products!.length >= 2
                                      //     ? Padding(
                                      //         padding:
                                      //             const EdgeInsets.symmetric(
                                      //                 vertical: 5.0),
                                      //         child: Text(
                                      //             "qty x ${_isAr ? order.products![1].nameAr : order.products![1].nameEn}",
                                      //             style: Theme.of(context)
                                      //                 .textTheme
                                      //                 .headline5!
                                      //                 .copyWith(
                                      //                     height: 1,
                                      //                     fontSize: 14,
                                      //                     fontWeight: FontWeight
                                      //                         .normal)),
                                      //       )
                                      //     : Container(),
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
                                      SizedBox(
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
                                                  value: AppLocalizations.of(
                                                          context)!
                                                      .tr(order.paymentTypeId ==
                                                              1
                                                          ? "cod"
                                                          : "online_payment"),
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start),
                                              ItemColumn(
                                                  title: 'order_status',
                                                  value: isAr
                                                      ? order
                                                          .orderState!.stateAr!
                                                      : order
                                                          .orderState!.stateEn!,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 20.0),
                                        child: SizedBox(
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
                                                    value: DateTime(
                                                            date.year,
                                                            date.month,
                                                            (date.day),
                                                            (date.hour +
                                                                timeZoneInHours))
                                                        .toString()
                                                        .substring(0, 10),
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start),
                                                ItemColumn(
                                                    title: 'order_type',
                                                    value: AppLocalizations.of(
                                                            context)!
                                                        .tr("delivery"),
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
                      child: SizedBox(
                        height: 55,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                    "${AppLocalizations.of(context)!.tr('total')}: ",
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600)),
                                Text(
                                    "${order.totalAmountAfterDiscount} ${sl<GetStrings>().getCurrency(isAr ? "ar" : "En", (order.refNo!.substring(0, 2)))}",
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal)),
                              ],
                            ),
                            // Container(
                            //   child: Row(
                            //     crossAxisAlignment: CrossAxisAlignment.center,
                            //     children: [
                            //       Text(
                            //           AppLocalizations.of(context)!
                            //               .tr('points_earned'),
                            //           style: TextStyle(
                            //               color: Colors.white,
                            //               fontSize: 10,
                            //               fontWeight: FontWeight.w600)),
                            //       Container(
                            //         height: 17,
                            //         decoration: BoxDecoration(
                            //           gradient: LinearGradient(
                            //             begin: Alignment.bottomRight,
                            //             end: Alignment.bottomLeft,
                            //             colors: [
                            //               Colors.green,
                            //               Colors.green.withOpacity(0.8),
                            //             ],
                            //           ), // color: Color.fromRGBO(212, 175, 55, 1),
                            //           shape: BoxShape.rectangle,
                            //           borderRadius: BorderRadius.all(
                            //               const Radius.circular(15)),
                            //           border:
                            //               Border.all(color: Colors.transparent),
                            //         ),
                            //         child: Padding(
                            //           padding: const EdgeInsets.symmetric(
                            //               horizontal: 3),
                            //           child: Text(
                            //               "points  ${AppLocalizations.of(context)!.tr('point')}",
                            //               style: TextStyle(
                            //                   fontSize: 10,
                            //                   fontWeight: FontWeight.bold,
                            //                   height: 1.3,
                            //                   color: Colors.white)),
                            //         ),
                            //       )
                            //     ],
                            //   ),
                            // ),
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
                          shape: BoxShape.rectangle,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                          border: Border.all(color: Colors.white, width: 1),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                              AppLocalizations.of(context)!.tr('order_details'),
                              style: const TextStyle(
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
