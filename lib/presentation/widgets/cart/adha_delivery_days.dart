import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'adha_delivery_days_item.dart';
import '../../../controllers/cart_provider.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/size_config.dart';
import '../../../models/cart_data.dart';

class AdhaDeliveryDays extends StatelessWidget {
  const AdhaDeliveryDays({super.key});
  @override
  Widget build(BuildContext context) {
    final CartProvider cart = Provider.of<CartProvider>(context);
    final List<String> days = [
      AppLocalizations.of(context)!.tr('first_day'),
      AppLocalizations.of(context)!.tr('second_day'),
      AppLocalizations.of(context)!.tr('third_day'),
      AppLocalizations.of(context)!.tr('fourth_day'),
    ];
    final List<String> date = [
      "2022-06-29",
      "2022-06-30",
      "2022-06-31",
      "2022-07-01",
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 15.0, top: 30, left: 15),
          child: Text(
            AppLocalizations.of(context)!.tr('choose_the_day_of_sacrifice'),
            style: Theme.of(context)
                .textTheme
                .displayLarge!
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
              itemCount: 4,
              itemBuilder: (BuildContext ctxt, int index) {
                return Visibility(
                  visible: checkDate(
                      cart.cartData!.data!.notIncludedDates!, date[index]),
                  child: Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(3.0, 15, 10, 0),
                    child: AdhaDeliveryDaysItem(
                      title: days[index],
                      selectedValue: index,
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }

  bool checkDate(List<NotIncludedDates> notIncludedDates, String date) {
    bool status = true;
    for (int i = 0; i < notIncludedDates.length; i++) {
      if (date.trim() == notIncludedDates[i].deliveryDate!.trim()) return false;
    }
    return status;
  }
}
