import 'package:flutter/material.dart';
import 'package:new_turki/provider/auth.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/widgets/shared/main_card.dart';
import 'package:provider/provider.dart';

class GiftCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<Auth>(context);
    return MainCard(
        padding: EdgeInsets.only(bottom: 30, right: 10, left: 10, top: 20),
        height: 200,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topLeft,
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).primaryColor.withOpacity(0.9),
              ],
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 20),
                      child: Text(AppLocalizations.of(context)!.tr('gift_card'),
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(
                                  color: Colors.white,
                                  height: 3,
                                  fontSize: 18))),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 20),
                    child: Image.asset(
                      'assets/images/turki_icon.png',
                      width: 60,
                      height: 100,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0.0, horizontal: 20),
                      child: Text(
                          _auth.giftController.text.isEmpty
                              ? "0000 0000 0000 0000"
                              : "${_auth.giftController.text.replaceAllMapped(RegExp(r".{4}"), (match) => "${match.group(0)} ")}",
                          textDirection: TextDirection.ltr,
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(
                                  color: Colors.white,
                                  fontSize: 18,
                                  height: 2))),
                ],
              ),
              Visibility(
                visible: _auth.cardValue > 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 20),
                        child: Text(
                            "${_auth.cardValue} ${AppLocalizations.of(context)!.tr('sr')}",
                            style: Theme.of(context)
                                .textTheme
                                .headline1!
                                .copyWith(
                                    color: Colors.white,
                                    fontSize: 14,
                                    height: 2))),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
