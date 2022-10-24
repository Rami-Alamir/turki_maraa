import 'package:flutter/material.dart';
import '../../../models/wallet.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/get_strings.dart';
import '../../../core/utilities/size_config.dart';
import 'package:provider/provider.dart';
import '../../../controllers/location_provider.dart';

class TransactionRow extends StatelessWidget {
  final Wallet transaction;
  const TransactionRow({Key? key, required this.transaction}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final bool status = transaction.after! > 0;
    final Color color = status ? Colors.green : Colors.red;
    final LocationProvider locationProvider =
        Provider.of<LocationProvider>(context, listen: false);
    String currency = GetStrings().getCurrency(
        AppLocalizations.of(context)!.locale!.languageCode,
        locationProvider.isoCountryCode!);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        color: Colors.transparent,
        elevation: 1,
        shadowColor:
            Theme.of(context).textTheme.headline4!.color!.withOpacity(0.1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        child: SizedBox(
          width: SizeConfig.screenWidth,
          height: 87,
          child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              child: Container(
                  constraints: const BoxConstraints(minHeight: 70),
                  width: SizeConfig.screenWidth,
                  color: Theme.of(context).colorScheme.secondary,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 5),
                    child: SizedBox(
                      height: 77,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Container(
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                color: transaction.color,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Icon(
                                  transaction.iconData,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: SizeConfig.screenWidth! - 100,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    SizedBox(
                                      width: SizeConfig.screenWidth! * 0.5,
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                            ' ${transaction.description}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline1!
                                                .copyWith(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          '${transaction.after!}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline1!
                                              .copyWith(
                                                  fontSize: 14, color: color),
                                        ),
                                        Text(
                                          currency,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline1!
                                              .copyWith(
                                                  fontSize: 12, color: color),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 0.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(5, 10, 0, 0),
                                        child: Text(
                                          transaction.date!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline4!
                                              .copyWith(
                                                  fontSize: 12,
                                                  fontWeight:
                                                      FontWeight.normal),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 10, 0, 0),
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                              transaction.before.toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2!
                                                  .copyWith(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.normal),
                                            ),
                                            Text(
                                              currency,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2!
                                                  .copyWith(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.normal),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ))),
        ),
      ),
    );
  }
}
