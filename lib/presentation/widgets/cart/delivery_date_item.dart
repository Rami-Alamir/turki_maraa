import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controllers/cart_provider.dart';
import '../../../core/constants/app_colors.dart';

class DeliveryDateItem extends StatelessWidget {
  final int selectedValue;
  final String title;
  final String subtitle;
  final String month;
  const DeliveryDateItem(
      {super.key,
      required this.selectedValue,
      required this.title,
      required this.subtitle,
      required this.month});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(builder: (_, cartProvider, __) {
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
                padding: const EdgeInsets.only(right: 8.0, left: 8, top: 10),
                child: Text(
                  subtitle,
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      fontSize: 11,
                      fontWeight: FontWeight.normal,
                      color: selected
                          ? AppColors.white
                          : Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .color!
                              .withOpacity(0.6)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0, left: 8, top: 10),
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      fontSize: 18,
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
              Padding(
                padding: const EdgeInsets.only(right: 8.0, left: 8, top: 10),
                child: Text(
                  month,
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      fontSize: 11,
                      fontWeight: FontWeight.normal,
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
    });
  }
}
