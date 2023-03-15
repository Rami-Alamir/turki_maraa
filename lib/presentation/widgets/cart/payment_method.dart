import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'payment_installment_item.dart';
import 'payment_method_item.dart';
import '../../../controllers/cart_provider.dart';
import '../../../core/constants/fixed_assets.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/t_u_r_k_i_i_c_o_n_s_icons.dart';

class PaymentMethod extends StatelessWidget {
  const PaymentMethod({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final CartProvider cartProvider = Provider.of<CartProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(right: 15.0, top: 15, left: 15, bottom: 5),
          child: Text(
            AppLocalizations.of(context)!.tr('payment_method'),
            style: Theme.of(context)
                .textTheme
                .displayMedium!
                .copyWith(fontSize: 14),
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 15, 0),
          child: Wrap(
            children: [
              PaymentMethodItem(
                visible: cartProvider.cashAvailable,
                selectedValue: 1,
                title: 'cod',
                subtitle: 'cod_description',
                icon: TURKIICONS.cart_cash_uncolored,
              ),
              PaymentMethodItem(
                visible: cartProvider.onlineAvailable,
                selectedValue: 2,
                title: 'online_payment',
                subtitle: 'online_payment_description',
                icon: TURKIICONS.cart_online_uncolored,
              ),
              PaymentInstallmentItem(
                visible: cartProvider.tamaraAvailable,
                selectedValue: 4,
                title: 'tamara_desc',
                logo: AppLocalizations.of(context)!.locale!.languageCode == 'ar'
                    ? FixedAssets.tamaraAr
                    : FixedAssets.tamaraEn,
              ),
              PaymentInstallmentItem(
                visible: cartProvider.tabbyAvailable,
                selectedValue: 7,
                title: 'tabby_desc',
                logo: FixedAssets.tabby,
              )
            ],
          ),
        ),
      ],
    );
  }
}
