import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controllers/cart_provider.dart';
import '../../../core/constants/fixed_assets.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/size_config.dart';

class TamaraCard extends StatelessWidget {
  const TamaraCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CartProvider cartProvider = Provider.of<CartProvider>(context);
    final bool selected = cartProvider.selectedPayment == 4;
    final double total =
        cartProvider.cartData!.data!.invoicePreview!.totalAmountAfterDiscount!;
    return Visibility(
      visible: (cartProvider.tamaraData?.data?.length ?? 0) > 0
          ? ((500.0 <= total) &&
              (((cartProvider.tamaraData?.data?[0].maxLimit?.amount ?? 0.0) *
                      1.0) >=
                  total))
          : false,
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(15.0, 0, 15, 10),
        child: InkWell(
          onTap: () {
            cartProvider.setSelectedPayment = 4;
          },
          child: Container(
              padding: const EdgeInsets.all(10.0),
              constraints: BoxConstraints(
                minHeight: 80,
                minWidth: SizeConfig.setWidgetWidth(
                    SizeConfig.screenWidth!, 200, 200),
                maxWidth: SizeConfig.setWidgetWidth(
                    SizeConfig.screenWidth!, 400, 400),
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: SizeConfig.setWidgetWidth(95, 130, 130),
                        child: Image.asset(AppLocalizations.of(context)!
                                    .locale!
                                    .languageCode ==
                                'ar'
                            ? FixedAssets.tamaraAr
                            : FixedAssets.tamaraEn),
                      ),
                      Text(
                        AppLocalizations.of(context)!.tr('tamara_desc'),
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                            fontSize: 11,
                            height: 2.2,
                            fontWeight: FontWeight.bold,
                            color: selected
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
