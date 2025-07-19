import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controllers/cart_provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/service/service_locator.dart';
import '../../../core/utilities/datetime_helper.dart';

class DeliveryPeriodsItem extends StatelessWidget {
  final int selectedValue;
  final String title;
  final String timeHhmm;

  const DeliveryPeriodsItem({
    super.key,
    required this.selectedValue,
    required this.title,
    required this.timeHhmm,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (_, cartProvider, _) {
        final bool selected = cartProvider.selectedTime == selectedValue;
        return cartProvider.isAdhia ||
                sl<DateTimeHelper>().checkPeriod(
                  timeHhmm: timeHhmm,
                  date: cartProvider.deliveryDataTime[cartProvider.selectedDate]
                      .toString()
                      .substring(0, 11),
                )
            ? InkWell(
                onTap: () {
                  cartProvider.setSelectedTime = selectedValue;
                },
                child: Container(
                  padding: const EdgeInsets.all(3.0),
                  margin: const EdgeInsetsDirectional.fromSTEB(3.0, 15, 10, 10),
                  height: 20,
                  decoration: BoxDecoration(
                    color: selected
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.outline,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 12.0,
                          left: 12,
                          top: 3,
                        ),
                        child: Text(
                          title,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.displayLarge!
                              .copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: selected
                                    ? AppColors.white
                                    : Theme.of(context)
                                          .textTheme
                                          .displayLarge!
                                          .color!
                                          .withValues(alpha: 0.6),
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : const SizedBox.shrink();
      },
    );
  }
}
