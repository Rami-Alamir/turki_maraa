import 'package:flutter/material.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/t_u_r_k_i_i_c_o_n_s_icons.dart';
import 'payment_method_item.dart';
import 'tamara_card.dart';

class PaymentMethod extends StatelessWidget {
  final bool withTamara;

  const PaymentMethod({Key? key, required this.withTamara}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(top: 30.0, right: 15, left: 15, bottom: 15),
          child: Text(
            AppLocalizations.of(context)!.tr('payment_method'),
            style: Theme.of(context)
                .textTheme
                .headline1!
                .copyWith(fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            PaymentMethodItem(
              selectedValue: 1,
              title: 'cod',
              subtitle: 'cod_description',
              icon: TURKIICONS.cart_cash_uncolored,
              padding: EdgeInsetsDirectional.fromSTEB(15.0, 10, 15, 10),
            ),
            PaymentMethodItem(
                selectedValue: 2,
                title: 'online_payment',
                subtitle: 'online_payment_description',
                icon: TURKIICONS.cart_online_uncolored,
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 10, 15, 10))
          ],
        ),
        const TamaraCard()
      ],
    );
  }
}
