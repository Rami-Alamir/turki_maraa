import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'payment_installment_item.dart';
import 'payment_method_item.dart';
import 'use_credit.dart';

import '../../../controllers/location_provider.dart';
import '../../../controllers/cart_provider.dart';
import '../../../core/constants/fixed_assets.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/t_u_r_k_i_i_c_o_n_s_icons.dart';

class PaymentMethod extends StatelessWidget {
  const PaymentMethod({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (_, cartProvider, _) {
        final double total = cartProvider
            .cartData!
            .data!
            .invoicePreview!
            .totalAmountAfterDiscount!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                right: 15.0,
                top: 15,
                left: 15,
                bottom: 5,
              ),
              child: Text(
                AppLocalizations.of(context)!.tr('payment_method'),
                style: Theme.of(
                  context,
                ).textTheme.displayMedium!.copyWith(fontSize: 14),
              ),
            ),
            if (cartProvider.isoCountryCode == 'SA') const UseCredit(),
            if (cartProvider.selectedPayment != 8 &&
                cartProvider.selectedPayment != 16)
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 15, 0),
                child: Wrap(
                  children: [
                    if (cartProvider.applePayAvailable &&
                        cartProvider.isoCountryCode == "SA")
                      const PaymentMethodItem(
                        selectedValue: 17,
                        isApplePay: true,
                        title: 'applepay',
                        subtitle: 'applepay',
                        icon: TURKIICONS.cart_online_uncolored,
                      ),
                    if (cartProvider.onlineAvailable)
                      const PaymentMethodItem(
                        selectedValue: 2,
                        title: 'online_payment',
                        subtitle: 'online_payment_description',
                        icon: TURKIICONS.cart_online_uncolored,
                      ),
                    if (context.read<LocationProvider>().isoCountryCode ==
                            "SA" &&
                        cartProvider.tamaraAvailable &&
                        (100 <= total) &&
                        total <= 5000)
                      PaymentInstallmentItem(
                        selectedValue: 4,
                        title: 'tamara_desc',
                        logo:
                            AppLocalizations.of(
                                  context,
                                )!.locale!.languageCode ==
                                'ar'
                            ? FixedAssets.tamaraAr
                            : FixedAssets.tamaraEn,
                      ),
                    if (cartProvider.tabbyAvailable &&
                        (100 <= total) &&
                        cartProvider.isoCountryCode != 'AE')
                      const PaymentInstallmentItem(
                        selectedValue: 7,
                        title: 'tabby_desc',
                        logo: FixedAssets.tabby,
                      ),
                    if (cartProvider.cashAvailable &&
                        !cartProvider.useCredit &&
                        !cartProvider.useCashTurki &&
                        !cartProvider.isAdhia)
                      const PaymentMethodItem(
                        selectedValue: 1,
                        title: 'cod',
                        subtitle: 'cod_description',
                        icon: TURKIICONS.cart_cash_uncolored,
                      ),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }
}
