import 'package:flutter/material.dart';
import '../../../../models/wallet.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/service/service_locator.dart';
import '../../../../core/utilities/get_strings.dart';
import '../../../../core/utilities/format_helper.dart';
import '../../../../core/utilities/size_config.dart';

class TransactionRow extends StatelessWidget {
  final WalletLogs transaction;
  final String currency;
  const TransactionRow(
      {super.key, required this.transaction, required this.currency});
  @override
  Widget build(BuildContext context) {
    final bool status = (double.parse(transaction.newAmount ?? "0") -
            double.parse(transaction.lastAmount ?? "0")) >
        0;
    final Color color = status ? AppColors.green : AppColors.red;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        color: Colors.transparent,
        elevation: 1,
        shadowColor:
            Theme.of(context).textTheme.headlineMedium!.color!.withOpacity(0.1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              color: Theme.of(context).colorScheme.surface,
            ),
            constraints: const BoxConstraints(minHeight: 85),
            width: SizeConfig.screenWidth,
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
            child: Row(
              children: [
                Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                  margin: const EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                  child: Center(
                    child: Icon(
                      status ? Icons.arrow_upward : Icons.arrow_downward,
                      color: AppColors.white,
                    ),
                  ),
                ),
                SizedBox(
                  width: SizeConfig.screenWidth! - 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SizedBox(
                            width: SizeConfig.screenWidth! * 0.5,
                            child: Text(
                              "${sl<GetStrings>().getWalletDescription(context, transaction.action ?? "")} ${transaction.actionId ?? ""}",
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                sl<FormatHelper>()
                                    .formatDecimalAndRemoveTrailingZeros(
                                        double.parse(
                                                transaction.newAmount ?? "0") -
                                            double.parse(
                                                transaction.lastAmount ?? "0")),
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(fontSize: 14, color: color),
                              ),
                              Text(
                                " $currency",
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(fontSize: 12, color: color),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                5, 10, 0, 0),
                            child: Text(
                              (transaction.createdAt ?? "").substring(0, 10),
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 10, 0, 0),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  sl<FormatHelper>()
                                      .formatDecimalAndRemoveTrailingZeros(
                                          double.parse(
                                              transaction.newAmount ?? "0")),
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal),
                                ),
                                Text(
                                  " $currency",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(
                                          fontSize: 10,
                                          fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
