import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/cart_provider.dart';
import '../../utilities/app_localizations.dart';
import '../../utilities/size_config.dart';

class TamaraCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _cartProvider = Provider.of<CartProvider>(context);
    final bool _selected = _cartProvider.selectedPayment == 4;
    final double total =
        _cartProvider.cartData!.data!.invoicePreview!.totalAmountAfterDiscount!;
    return Visibility(
      visible: (_cartProvider.tamaraData?.data?.length ?? 0) > 0
          ? ((500.0 <= total) &&
              (((_cartProvider.tamaraData?.data?[0].maxLimit?.amount ?? 0.0) *
                      1.0) >=
                  total))
          : false,
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(15.0, 0, 0, 10),
        child: InkWell(
          onTap: () {
            _cartProvider.setSelectedPayment = 4;
          },
          child: Container(
              padding: const EdgeInsets.all(10.0),
              constraints: BoxConstraints(
                minHeight: 80,
                minWidth: SizeConfig.setWidgetWidth(180, 200, 200),
                maxWidth: SizeConfig.setWidgetWidth(340, 400, 400),
              ),
              decoration: BoxDecoration(
                  color: _selected
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).colorScheme.primaryVariant,
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: SizeConfig.setWidgetWidth(95, 130, 130),
                        child: Image.asset(AppLocalizations.of(context)!
                                    .locale!
                                    .languageCode ==
                                'ar'
                            ? "assets/images/tamara_ar.png"
                            : "assets/images/tamara_en.png"),
                      ),
                      Text(
                        'قسمها على دفعات بدون رسوم',
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                            fontSize: 11,
                            height: 2.2,
                            fontWeight: FontWeight.bold,
                            color: _selected
                                ? Colors.white
                                : Theme.of(context).textTheme.headline5!.color),
                      ),
                    ],
                  )
                ],
              )),
        ),
      ),
    );
  }
}
