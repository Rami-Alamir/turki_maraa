import 'package:flutter/material.dart';
import '../../../../core/service/service_locator.dart';
import '../../../../core/utilities/format_helper.dart';

class WalletCard extends StatelessWidget {
  final String title;
  final String currency;
  final String value;

  const WalletCard({
    super.key,
    required this.title,
    required this.value,
    required this.currency,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final titleStyle = theme.textTheme.displayLarge!.copyWith(
      fontSize: 18,
      color: Colors.white,
    );

    final valueStyle = theme.textTheme.displayLarge!.copyWith(
      fontSize: 24,
      color: Colors.white,
    );

    return Container(
      height: 230,
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: theme.colorScheme.tertiaryContainer,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 6)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: titleStyle),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                sl<FormatHelper>().formatDecimalAndRemoveTrailingZeros(
                  double.parse(value),
                ),
                style: valueStyle,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4.0, top: 4.0, right: 4),
                child: Text(currency, style: titleStyle),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
