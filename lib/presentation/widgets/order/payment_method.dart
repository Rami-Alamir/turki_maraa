import 'package:flutter/material.dart';
import '../../../core/constants/fixed_assets.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../widgets/shared/main_card.dart';

class PaymentMethod extends StatelessWidget {
  final int paymentTypeId;

  const PaymentMethod({Key? key, this.paymentTypeId = 2}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
          child: Text(
            AppLocalizations.of(context)!.tr('payment_method'),
            style: Theme.of(context)
                .textTheme
                .headline1!
                .copyWith(fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ),
        MainCard(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Image.network(
              //     paymentMethod.image,
              //     width: 35,
              //     height: 35,
              //   ),
              // ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(8.0, 0, 0, 0),
                child: paymentTypeId == 4
                    ? Image.asset(
                        AppLocalizations.of(context)!.locale!.languageCode ==
                                'ar'
                            ? FixedAssets.tamaraAr
                            : FixedAssets.tamaraEn,
                        width: 70,
                        height: 40,
                      )
                    : Text(
                        AppLocalizations.of(context)!
                            .tr(paymentTypeId == 1 ? "cod" : "online_payment"),
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            )),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
