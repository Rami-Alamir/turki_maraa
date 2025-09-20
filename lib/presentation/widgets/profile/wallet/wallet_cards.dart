import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'wallet_card.dart';
import '../../../../controllers/user_provider.dart';
import '../../../../core/utilities/app_localizations.dart';

class WalletCards extends StatelessWidget {
  final String currency;

  const WalletCards({super.key, required this.currency});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 330,
      child: Consumer<UserProvider>(
        builder: (_, userProvider, _) {
          final int active = userProvider.activeCard;
          final int inactive = active == 0 ? 1 : 0;
          final List<int> order = [inactive, active];

          return Stack(
            clipBehavior: Clip.none,
            children: order.map((type) {
              bool isActive = type == active;
              double top = isActive ? 70 : 10;
              double scale = isActive ? 1.0 : 0.95;
              double opacity = isActive ? 1.0 : 0.8;

              String title;
              String value;
              if (type == 0) {
                title = AppLocalizations.of(context)!.tr('credit');
                value = userProvider.wallet?.data?.wallet ?? "0";
              } else {
                title = AppLocalizations.of(context)!.tr('cash_turki');
                value = userProvider.cashTurki?.data?.cashturki ?? "0";
              }
              return AnimatedPositioned(
                key: ValueKey(type),
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeInOut,
                top: top,
                left: 0,
                right: 0,
                child: GestureDetector(
                  onTap: userProvider.swapCards,
                  child: AnimatedScale(
                    scale: scale,
                    duration: const Duration(milliseconds: 350),
                    curve: Curves.easeInOut,
                    child: AnimatedOpacity(
                      opacity: opacity,
                      duration: const Duration(milliseconds: 350),
                      child: WalletCard(
                        title: title,
                        value: value,
                        currency: currency,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
