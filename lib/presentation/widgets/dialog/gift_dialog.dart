import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:turki_dabayh/core/constants/fixed_assets.dart';

class GiftDialog extends StatelessWidget {
  const GiftDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        backgroundColor: Theme.of(context).backgroundColor,
        contentPadding: const EdgeInsets.all(0),
        content: Builder(
          builder: (context) {
            return Container(
              constraints: const BoxConstraints(maxWidth: 500, minWidth: 300),
              height: 400,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(12, 0, 10, 20),
                    child: Lottie.asset(FixedAssets.congratulations,
                        width: 200, height: 200),
                  ),
                  Text(
                    "مبروك",
                    style: Theme.of(context)
                        .textTheme
                        .headline1!
                        .copyWith(fontSize: 18, height: 1),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 8.0, right: 20, left: 20),
                    child: Text(
                      "لقد ربحت خصم ١٠٠ ريال عند شرائك بقيمة ٩٩٩ أو اكثر باستخدام الكود s100",
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2!
                          .copyWith(fontSize: 14),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
