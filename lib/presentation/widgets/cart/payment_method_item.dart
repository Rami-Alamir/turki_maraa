import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controllers/cart_provider.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/size_config.dart';
import '../../../core/constants/app_colors.dart';

class PaymentMethodItem extends StatelessWidget {
  final int selectedValue;
  final String title;
  final String subtitle;
  final IconData icon;
  final EdgeInsetsDirectional padding;
  final bool visible;

  const PaymentMethodItem(
      {Key? key,
      required this.selectedValue,
      required this.title,
      required this.subtitle,
      required this.icon,
      this.padding = const EdgeInsetsDirectional.fromSTEB(15.0, 15, 0, 0),
      required this.visible})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CartProvider cartProvider = Provider.of<CartProvider>(context);
    final bool selected = cartProvider.selectedPayment == selectedValue;
    return Visibility(
      visible: visible,
      child: InkWell(
        onTap: () {
          cartProvider.setSelectedPayment = selectedValue;
        },
        child: Container(
            margin: padding,
            width: SizeConfig.setWidgetWidth(
                SizeConfig.screenWidth! / 2 - 22.5, 200, 200),
            padding: const EdgeInsets.all(3.0),
            constraints: const BoxConstraints(
              minHeight: 92,
            ),
            decoration: BoxDecoration(
                color: selected
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.outline,
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 45,
                  width: 45,
                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                  decoration: BoxDecoration(
                      color: selected ? AppColors.purple2 : AppColors.white,
                      shape: BoxShape.circle),
                  child: Icon(
                    icon,
                    size: 40,
                    color: selected ? AppColors.white : AppColors.black,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: SizeConfig.setWidgetWidth(95, 130, 130),
                      child: Text(
                        AppLocalizations.of(context)!.tr(title),
                        maxLines: 2,
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(
                                fontSize: 11,
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
                    SizedBox(
                      width: SizeConfig.setWidgetWidth(90, 120, 120),
                      child: Text(
                        AppLocalizations.of(context)!.tr(subtitle),
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(
                                fontSize: 8,
                                fontWeight: FontWeight.normal,
                                height: 2,
                                color: selected
                                    ? AppColors.white
                                    : Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .color),
                      ),
                    ),
                  ],
                )
              ],
            )),
      ),
    );
  }
}
