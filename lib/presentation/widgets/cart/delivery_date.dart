import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../models/cart_data.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/size_config.dart';
import 'delivery_date_item.dart';

class DeliveryDate extends StatelessWidget {
  final List<DateTime> deliveryDataTime;
  final List<NotIncludedDates> notIncludedDates;
  const DeliveryDate(
      {Key? key,
      required this.deliveryDataTime,
      required this.notIncludedDates})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 15.0, top: 15, left: 15),
          child: Text(
            AppLocalizations.of(context)!.tr('delivery_date'),
            style: Theme.of(context)
                .textTheme
                .headline1!
                .copyWith(fontWeight: FontWeight.bold, fontSize: 14),
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
              itemCount: deliveryDataTime.length,
              itemBuilder: (BuildContext ctxt, int index) {
                return Visibility(
                  visible: checkDate(notIncludedDates,
                      deliveryDataTime[index].toString().substring(0, 11)),
                  child: Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(3.0, 15, 10, 10),
                    child: DeliveryDateItem(
                      selectedValue: index,
                      title: deliveryDataTime[index].day.toString(),
                      subtitle:
                          deliveryDataTime[index].day == DateTime.now().day
                              ? AppLocalizations.of(context)!.tr('today')
                              : deliveryDataTime[index].day ==
                                      (DateTime.now().day + 1)
                                  ? AppLocalizations.of(context)!.tr('tomorrow')
                                  : DateFormat.E(AppLocalizations.of(context)!
                                          .locale!
                                          .languageCode)
                                      .format(deliveryDataTime[index]),
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
