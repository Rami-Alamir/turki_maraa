import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'delivery_date_item.dart';
import '../../../controllers/cart_provider.dart';
import '../../../models/cart_data.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/size_config.dart';

class DeliveryDate extends StatelessWidget {
  const DeliveryDate({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CartProvider cart = Provider.of<CartProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 15.0, top: 15, left: 15),
          child: Text(
            AppLocalizations.of(context)!.tr('delivery_date'),
            style: Theme.of(context)
                .textTheme
                .displayLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          width: SizeConfig.screenWidth,
          height: 122,
          child: ListView.builder(
              padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: const ScrollPhysics(),
              itemCount: cart.deliveryDataTime.length,
              itemBuilder: (BuildContext ctxt, int index) {
                return Visibility(
                  visible: checkDate(cart.cartData!.data!.notIncludedDates!,
                      cart.deliveryDataTime[index].toString().substring(0, 11)),
                  child: Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(3.0, 15, 10, 10),
                    child: DeliveryDateItem(
                      selectedValue: index,
                      title: cart.deliveryDataTime[index].day.toString(),
                      subtitle:
                          cart.deliveryDataTime[index].day == DateTime.now().day
                              ? AppLocalizations.of(context)!.tr('today')
                              : cart.deliveryDataTime[index].day ==
                                      (DateTime.now().day + 1)
                                  ? AppLocalizations.of(context)!.tr('tomorrow')
                                  : DateFormat.E(AppLocalizations.of(context)!
                                          .locale!
                                          .languageCode)
                                      .format(cart.deliveryDataTime[index]),
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }

  // check date to hide notIncludedDates
  bool checkDate(List<NotIncludedDates> notIncludedDates, String date) {
    bool status = true;
    for (int i = 0; i < notIncludedDates.length; i++) {
      if (date.trim() == notIncludedDates[i].deliveryDate!.trim()) return false;
    }
    return status;
  }
}
