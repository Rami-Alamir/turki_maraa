import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'custom_checkbox.dart';
import '../../../controllers/location_provider.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../controllers/cart_provider.dart';
import '../../../core/service/service_locator.dart';
import '../../../core/utilities/get_strings.dart';
import '../../../core/utilities/format_helper.dart';
import '../../../core/utilities/size_config.dart';

class UseCredit extends StatelessWidget {
  const UseCredit({super.key});
  @override
  Widget build(BuildContext context) {
    String currency = sl<GetStrings>().getCurrency(
      AppLocalizations.of(context)!.locale!.languageCode,
      context.read<LocationProvider>().isoCountryCode!,
    );
    return Consumer<CartProvider>(
      builder: (_, cartProvider, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            if ((cartProvider.cartData?.data?.cashTurki ?? 0) > 0)
              CustomCheckbox(
                cheeked: cartProvider.useCashTurki,
                title:
                    '${AppLocalizations.of(context)!.tr('use_cash_turki')} (${sl<FormatHelper>().formatDecimalAndRemoveTrailingZeros(cartProvider.cartData?.data?.cashTurki ?? 0)} $currency)',
                onTap: () {
                  HapticFeedback.heavyImpact();
                  cartProvider.ussCashTurki = !cartProvider.useCashTurki;
                },
                width: SizeConfig.screenWidth! - 150,
              ),

            if ((cartProvider.cartData?.data?.customerWallet ?? 0) > 0 &&
                cartProvider.selectedPayment != 16)
              CustomCheckbox(
                cheeked: cartProvider.useCredit,
                title:
                    '${AppLocalizations.of(context)!.tr('use_my_credit')} (${sl<FormatHelper>().formatDecimalAndRemoveTrailingZeros(cartProvider.cartData?.data?.customerWallet ?? 0)} $currency)',
                onTap: () {
                  HapticFeedback.heavyImpact();
                  cartProvider.usMyCredit = !cartProvider.useCredit;
                },
                width: SizeConfig.screenWidth! - 150,
              ),
          ],
        );
      },
    );
  }
}
