import 'package:flutter/material.dart';
import 'package:new_turki/models/points_tran.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/size_config.dart';

class PointTransactionRow extends StatelessWidget {
  final PointsTran transaction;
  const PointTransactionRow({required this.transaction});
  @override
  Widget build(BuildContext context) {
    final bool status = transaction.after > 0;
    final Color color = status ? Colors.green : Colors.red;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        color: Colors.transparent,
        elevation: 500,
        shadowColor:
            Theme.of(context).colorScheme.secondaryVariant.withOpacity(0.14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        child: ClipRRect(
            borderRadius: BorderRadius.all(const Radius.circular(5)),
            child: Container(
                width: SizeConfig.screenWidth,
                color: Theme.of(context).colorScheme.secondary,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Row(
                                  children: [
                                    Image.asset(
                                      transaction.image,
                                      width: 30,
                                      height: 30,
                                    ),
                                    Container(
                                      width: SizeConfig.screenWidth! * .58,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 6.0),
                                        child: Text(
                                          '${transaction.description}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline1!
                                              .copyWith(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  '${transaction.after}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1!
                                      .copyWith(fontSize: 14, color: color),
                                ),
                                Text(
                                  AppLocalizations.of(context)!.tr('point'),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1!
                                      .copyWith(fontSize: 12, color: color),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 7.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    5, 5, 0, 0),
                                child: Text(
                                  transaction.date,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal),
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    transaction.before.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2!
                                        .copyWith(
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal),
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!.tr('point'),
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2!
                                        .copyWith(
                                            fontSize: 10,
                                            fontWeight: FontWeight.normal),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ))),
      ),
    );
  }
}
