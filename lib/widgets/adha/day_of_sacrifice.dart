import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:new_turki/provider/cart_provider.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:provider/provider.dart';

import '../../models/cart_data.dart';

class DayOfSacrifice extends StatelessWidget {
  final List<DateTime> deliveryDataTime;
  final List<NotIncludedDates> notIncludedDates;
  const DayOfSacrifice(
      {required this.deliveryDataTime, required this.notIncludedDates});
  @override
  Widget build(BuildContext context) {
    final List<String> _days = [
      AppLocalizations.of(context)!.tr('first_day'),
      AppLocalizations.of(context)!.tr('second_day'),
      AppLocalizations.of(context)!.tr('third_day'),
      AppLocalizations.of(context)!.tr('fourth_day'),
    ];
    final List<String> _date = [
      "2022-07-09",
      "2022-07-10",
      "2022-07-11",
      "2022-07-12",
    ];
    DateFormat format =
        DateFormat.E(AppLocalizations.of(context)!.locale!.languageCode);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 15.0, top: 30, left: 15),
          child: Text(
            AppLocalizations.of(context)!.tr('choose_the_day_of_sacrifice'),
            style: Theme.of(context)
                .textTheme
                .headline1!
                .copyWith(fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ),
        Container(
          width: SizeConfig.screenWidth,
          height: 122,
          child: ListView.builder(
              padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: const ScrollPhysics(),
              itemCount: 4,
              itemBuilder: (BuildContext ctxt, int index) {
                return Visibility(
                  visible: checkDate(notIncludedDates, _date[index]),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(3.0, 15, 10, 0),
                    child: _item(
                      context,
                      index,
                      _days[index],
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
    print('checkDate');
    print(date);
    for (int i = 0; i < notIncludedDates.length; i++) {
      print(notIncludedDates[i].deliveryDate);
      if (date.trim() == notIncludedDates[i].deliveryDate!.trim()) return false;
    }
    return status;
  }

  Widget _item(BuildContext context, int selectedValue, String title) {
    final _cartProvider = Provider.of<CartProvider>(context, listen: false);
    final bool selected = _cartProvider.selectedDate == selectedValue;

    return InkWell(
      onTap: () {
        _cartProvider.setSelectedDate = selectedValue;
      },
      child: Container(
        width: 80,
        padding: const EdgeInsets.all(3.0),
        constraints: const BoxConstraints(
          minHeight: 50,
        ),
        decoration: BoxDecoration(
            color: selected
                ? Theme.of(context).primaryColor
                : Theme.of(context).colorScheme.primaryVariant,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0, left: 8, top: 0),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline5!.copyWith(
                    fontSize: 14,
                    height: 1.5,
                    fontWeight: FontWeight.bold,
                    color: selected
                        ? Colors.white
                        : Theme.of(context).textTheme.headline5!.color),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
