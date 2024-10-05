import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../shared/rounded_rectangle_button.dart';
import '../../../controllers/auth.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/constants/fixed_assets.dart';

class GiftCreditDialog extends StatelessWidget {
  const GiftCreditDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      backgroundColor: Theme.of(context).colorScheme.onSurface,
      contentPadding: const EdgeInsets.all(0),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 10, 20),
            child: Lottie.asset(FixedAssets.congratulations,
                width: 200, height: 200),
          ),
          Text(
            "${AppLocalizations.of(context)!.tr('congratulations_you_got')} ${context.read<Auth>().userData?.data?.wallet ?? "0"} ${AppLocalizations.of(context)!.tr('balance_in_your_wallet')}",
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .displayMedium!
                .copyWith(fontSize: 16, height: 1.6),
          ),
          RoundedRectangleButton(
              title: AppLocalizations.of(context)!.tr('done'),
              fontSize: 14,
              height: 42,
              padding: const EdgeInsets.all(15),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ],
      ),
    );
  }
}
