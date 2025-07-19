import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../controllers/user_provider.dart';
import '../../../../core/service/service_locator.dart';
import '../../../../core/utilities/app_localizations.dart';
import '../../../../core/utilities/format_helper.dart';

class WalletHeader extends StatelessWidget {
  final String currency;
  const WalletHeader({super.key, required this.currency});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 60.0, bottom: 20),
          child: Column(
            children: [
              Consumer<UserProvider>(
                builder: (_, userProvider, _) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        sl<FormatHelper>().formatDecimalAndRemoveTrailingZeros(
                          double.parse(
                            userProvider.wallet?.data?.wallet ?? "0",
                          ),
                        ),
                        textAlign: TextAlign.center,
                        style: Theme.of(
                          context,
                        ).textTheme.displayLarge!.copyWith(fontSize: 40),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          currency,
                          textAlign: TextAlign.center,
                          style: Theme.of(
                            context,
                          ).textTheme.displayLarge!.copyWith(fontSize: 14),
                        ),
                      ),
                    ],
                  );
                },
              ),
              Text(
                AppLocalizations.of(context)!.tr('your_current_balance'),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  fontSize: 12,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
