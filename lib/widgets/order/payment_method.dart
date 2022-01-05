import 'package:flutter/material.dart';
import 'package:new_turki/models/order.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/widgets/shared/main_card.dart';

class PaymentMethod extends StatelessWidget {
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
              Text("صورة وطريقة الدفع هنا",
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      )),
            ],
          )),
        ),
      ],
    );
  }
}
