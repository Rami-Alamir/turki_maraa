import 'package:flutter/material.dart';
import '../../shared/main_card.dart';
import '../../../../core/constants/fixed_assets.dart';
import '../../../../core/utilities/app_localizations.dart';

class GiftCard extends StatelessWidget {
  const GiftCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainCard(
        padding:
            const EdgeInsets.only(bottom: 30, right: 10, left: 10, top: 20),
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
                              .displayLarge!
                              .copyWith(
                                  color: Colors.white,
                                  height: 3,
                                  fontSize: 18))),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 20),
                    child: Image.asset(
                      FixedAssets.logo,
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
                      child: Text("0000 0000 0000 0000",
                          // _auth.giftController.text.isEmpty
                          //     ? "0000 0000 0000 0000"
                          //     : "${_auth.giftController.text.replaceAllMapped(RegExp(r".{4}"), (match) => "${match.group(0)} ")}",
                          textDirection: TextDirection.ltr,
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(
                                  color: Colors.white,
                                  fontSize: 18,
                                  height: 2))),
                ],
              ),
              Visibility(
                // visible: _auth.cardValue > 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 20),
                        child: Text(
                            "100 ${AppLocalizations.of(context)!.tr('sr')}",
                            // "${_auth.cardValue} ${AppLocalizations.of(context)!.tr('sr')}",
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge!
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
