import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:new_turki/provider/cart_provider.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:provider/provider.dart';

class DeliveryDate extends StatelessWidget {
  final List<DateTime> deliveryDataTime;

  const DeliveryDate({required this.deliveryDataTime});
  @override
  Widget build(BuildContext context) {
    var format =
        DateFormat.E(AppLocalizations.of(context)!.locale!.languageCode);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 15.0, top: 30, left: 15),
          child: Text(
            AppLocalizations.of(context)!.tr('delivery_date'),
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
              padding: EdgeInsets.all(0),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: const ScrollPhysics(),
              itemCount: deliveryDataTime.length,
              itemBuilder: (BuildContext ctxt, int index) {
                return Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(
                      index == 0 ? 10 : 3.0, 15, 10, 0),
                  child: _item(
                    context,
                    index,
                    deliveryDataTime[index].day.toString(),
                    deliveryDataTime[index].day == DateTime.now().day
                        ? AppLocalizations.of(context)!.tr('today')
                        : deliveryDataTime[index].day ==
                                (DateTime.now().day + 1)
                            ? AppLocalizations.of(context)!.tr('tomorrow')
                            : format.format(deliveryDataTime[index]),
                  ),
                );
              }),
        ),
      ],
    );
  }

  Widget _item(
      BuildContext context, int selectedValue, String title, String subtitle) {
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
              padding: const EdgeInsets.only(right: 8.0, left: 8, top: 10),
              child: Text(
                subtitle,
                style: Theme.of(context).textTheme.headline5!.copyWith(
                    fontSize: 11,
                    fontWeight: FontWeight.normal,
                    color: selected
                        ? Colors.white
                        : Theme.of(context).textTheme.headline5!.color),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0, left: 8, top: 10),
              child: Text(
                title,
                style: Theme.of(context).textTheme.headline5!.copyWith(
                    fontSize: 18,
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
