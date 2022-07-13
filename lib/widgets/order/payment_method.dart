import 'package:flutter/material.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/widgets/shared/main_card.dart';

class PaymentMethod extends StatelessWidget {
  final int paymentTypeId;
  final String paymentName;

  const PaymentMethod({this.paymentTypeId = 2, this.paymentName = "cod"});
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
          child: Container(
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
                            ? "assets/images/tamara_ar.png"
                            : "assets/images/tamara_en.png",
                        width: 70,
                        height: 40,
                      )
                    : Text(
                        AppLocalizations.of(context)!.tr(paymentTypeId == 1
                            ? paymentName
                            : "online_payment"),
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            )),
              ),
            ],
          )),
        ),
      ],
    );
  }
}
