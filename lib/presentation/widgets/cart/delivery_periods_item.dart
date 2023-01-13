import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controllers/cart_provider.dart';

class DeliveryPeriodsItem extends StatelessWidget {
  final int selectedValue;
  final String title;
  const DeliveryPeriodsItem(
      {Key? key, required this.selectedValue, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CartProvider cartProvider =
        Provider.of<CartProvider>(context, listen: false);
    final bool selected = cartProvider.selectedTime == selectedValue;
    return InkWell(
      onTap: () {
        cartProvider.setSelectedTime = selectedValue;
      },
      splashColor: Colors.transparent,
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
