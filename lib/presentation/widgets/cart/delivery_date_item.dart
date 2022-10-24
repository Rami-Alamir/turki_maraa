import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controllers/cart_provider.dart';

class DeliveryDateItem extends StatelessWidget {
  final int selectedValue;
  final String title;
  final String subtitle;
  const DeliveryDateItem(
      {Key? key,
      required this.selectedValue,
      required this.title,
      required this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CartProvider cartProvider =
        Provider.of<CartProvider>(context, listen: false);
    final bool selected = cartProvider.selectedDate == selectedValue;

    return InkWell(
      onTap: () {
        cartProvider.setSelectedDate = selectedValue;
      },
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
        width: 80,
        padding: const EdgeInsets.all(3.0),
        constraints: const BoxConstraints(
          minHeight: 50,
        ),
        decoration: BoxDecoration(
            color: selected
                ? Theme.of(context).primaryColor
                : Theme.of(context).colorScheme.primaryContainer,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
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
