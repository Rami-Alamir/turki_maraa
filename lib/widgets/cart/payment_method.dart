import 'package:flutter/material.dart';
import 'package:new_turki/provider/cart_provider.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:new_turki/utilities/t_u_r_k_i_i_c_o_n_s_icons.dart';
import 'package:new_turki/widgets/cart/tamara_card.dart';
import 'package:provider/provider.dart';

class PaymentMethod extends StatelessWidget {
  final bool withTamara;

  const PaymentMethod({required this.withTamara});
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
          children: [
            _item(
                context,
                1,
                'cod',
                'cod_description',
                TURKIICONS.cart_cash_uncolored,
                EdgeInsetsDirectional.fromSTEB(15.0, 10, 15, 10)),
            _item(
                context,
                2,
                'online_payment',
                'online_payment_description',
                TURKIICONS.cart_online_uncolored,
                EdgeInsetsDirectional.fromSTEB(0.0, 10, 15, 10))
          ],
        ),
        TamaraCard()
      ],
    );
  }

  Widget _item(BuildContext context, int selectedValue, String title,
      String subtitle, IconData icon, EdgeInsetsDirectional padding) {
    final _cartProvider = Provider.of<CartProvider>(context, listen: false);
    final bool selected = _cartProvider.selectedPayment == selectedValue;
    return InkWell(
      onTap: () {
        _cartProvider.setSelectedPayment = selectedValue;
      },
      child: Padding(
        padding: padding,
        child: Container(
            width: SizeConfig.setWidgetWidth(
                SizeConfig.screenWidth! / 2 - 22.5, 200, 200),
            padding: const EdgeInsets.all(3.0),
            constraints: const BoxConstraints(
              minHeight: 92,
            ),
            decoration: BoxDecoration(
                color: selected
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).colorScheme.primaryContainer,
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                        color: selected
                            ? Color.fromRGBO(90, 4, 9, 1)
                            : Colors.white,
                        shape: BoxShape.circle),
                    child: Icon(
                      icon,
                      size: 40,
                      color: selected ? Colors.white : Colors.black,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: SizeConfig.setWidgetWidth(95, 130, 130),
                      child: Text(
                        AppLocalizations.of(context)!.tr(title),
                        maxLines: 2,
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                            fontSize: 11,
                            height: 1.5,
                            fontWeight: FontWeight.bold,
                            color: selected
                                ? Colors.white
                                : Theme.of(context).textTheme.headline5!.color),
                      ),
                    ),
                    SizedBox(
                      width: SizeConfig.setWidgetWidth(90, 120, 120),
                      child: Text(
                        AppLocalizations.of(context)!.tr(subtitle),
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                            fontSize: 8,
                            fontWeight: FontWeight.normal,
                            height: 2,
                            color: selected
                                ? Colors.white
                                : Theme.of(context).textTheme.headline5!.color),
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
