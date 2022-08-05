import 'package:flutter/material.dart';
import 'package:new_turki/provider/cart_provider.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:provider/provider.dart';

import '../../models/delivery_period.dart';

class DeliveryPeriods extends StatelessWidget {
  final DeliveryPeriod deliveryTime;

  const DeliveryPeriods({required this.deliveryTime});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 15.0, top: 30, left: 15),
          child: Text(
            AppLocalizations.of(context)!.tr('delivery_time'),
            style: Theme.of(context)
                .textTheme
                .headline1!
                .copyWith(fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ),
        Container(
          width: SizeConfig.screenWidth,
          height: 70,
          child: ListView.builder(
              padding: EdgeInsets.all(0),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: const ScrollPhysics(),
              itemCount: deliveryTime.data!.length,
              itemBuilder: (BuildContext ctxt, int index) {
                return Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(
                      index == 0 ? 10 : 3.0, 15, 10, 0),
                  child: _item(
                    context,
                    index,
                    AppLocalizations.of(context)!.locale!.languageCode == 'ar'
                        ? deliveryTime.data![index].nameAr!
                        : deliveryTime.data![index].nameEn!,
                  ),
                );
              }),
        ),
      ],
    );
  }

  Widget _item(BuildContext context, int selectedValue, String title) {
    final _cartProvider = Provider.of<CartProvider>(context, listen: false);

    final bool selected = _cartProvider.selectedTime == selectedValue;
    return InkWell(
      onTap: () {
        _cartProvider.setSelectedTime = selectedValue;
      },
      child: Container(
        padding: const EdgeInsets.all(3.0),
        height: 20,
        decoration: BoxDecoration(
            color: selected
                ? Theme.of(context).primaryColor
                : Theme.of(context).colorScheme.primaryContainer,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 12.0, left: 12, top: 3),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline5!.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
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
