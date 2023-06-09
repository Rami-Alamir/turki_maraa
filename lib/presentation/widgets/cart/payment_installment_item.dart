import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controllers/cart_provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/size_config.dart';

class PaymentInstallmentItem extends StatelessWidget {
  final int selectedValue;
  final String logo;
  final String title;
  final EdgeInsetsDirectional padding;
  final bool visible;

  const PaymentInstallmentItem({
    Key? key,
    required this.selectedValue,
    required this.title,
    required this.logo,
    this.padding = const EdgeInsetsDirectional.fromSTEB(15.0, 15, 0, 0),
    required this.visible,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CartProvider cartProvider = Provider.of<CartProvider>(context);
    final bool selected = cartProvider.selectedPayment == selectedValue;
    final double total =
        cartProvider.cartData!.data!.invoicePreview!.totalAmountAfterDiscount!;
    return Visibility(
      visible: visible && (cartProvider.tamaraData?.data?.length ?? 0) > 0
          ? ((500.0 <= total) &&
              (selectedValue == 4
                  ? (((cartProvider.tamaraData?.data?[0].maxLimit?.amount ??
                              0.0) *
                          1.0) >=
                      total)
                  : true))
          : false,
      child: InkWell(
        onTap: () {
          cartProvider.setSelectedPayment = selectedValue;
        },
        child: Container(
            margin: padding,
            width: SizeConfig.setWidgetWidth(
                SizeConfig.screenWidth! / 2 - 22.5, 200, 200),
            padding: const EdgeInsets.all(8.0),
            constraints: const BoxConstraints(
              minHeight: 92,
            ),
            decoration: BoxDecoration(
                color: selected
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.outline,
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Image.asset(
                    logo,
                    height: 30,
                  ),
                ),
                Text(
                  AppLocalizations.of(context)!.tr(title),
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                      color: selected
                          ? AppColors.white
                          : Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .color!
                              .withOpacity(0.6)),
                ),
              ],
            )),
      ),
    );
  }
}
