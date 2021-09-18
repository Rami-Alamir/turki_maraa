import 'package:flutter/material.dart';
import 'package:new_turki/models/wallet.dart';
import 'package:new_turki/utilities/size_config.dart';

class TransactionRow extends StatelessWidget {
  final Wallet transaction;
  const TransactionRow({required this.transaction});
  @override
  Widget build(BuildContext context) {
    final bool status = transaction.after! > 0;
    final Color color = status ? Colors.green : Colors.red;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        elevation: 1,
        shadowColor:
            Theme.of(context).textTheme.headline4!.color!.withOpacity(0.1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        child: Container(
          width: SizeConfig.screenWidth,
          height: 87,
          child: ClipRRect(
              borderRadius: BorderRadius.all(const Radius.circular(5)),
              child: Container(
                  constraints: BoxConstraints(minHeight: 70),
                  width: SizeConfig.screenWidth,
                  color: Theme.of(context).accentColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 5),
                    child: Container(
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
                          Container(
                            width: SizeConfig.screenWidth! * 0.70,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
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
                                          "ريال",
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
                                          '20//05/2021',
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
                                              "ريال",
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
