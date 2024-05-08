import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controllers/cart_provider.dart';
import '../../../core/constants/app_colors.dart';

class AdhaDeliveryDaysItem extends StatelessWidget {
  final int selectedValue;
  final String title;
  const AdhaDeliveryDaysItem(
      {super.key, required this.selectedValue, required this.title});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final bool selected = cartProvider.selectedDate == selectedValue;

    return InkWell(
      onTap: () {
        cartProvider.setSelectedDate = selectedValue;
      },
      child: Container(
        width: 80,
        padding: const EdgeInsets.all(3.0),
        constraints: const BoxConstraints(
          minHeight: 50,
        ),
        decoration: BoxDecoration(
            color: selected
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.outline,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0, left: 8, top: 0),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontSize: 14,
                    height: 1.5,
                    fontWeight: FontWeight.bold,
                    color: selected
                        ? AppColors.white
                        : Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .color!
                            .withOpacity(0.6)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
