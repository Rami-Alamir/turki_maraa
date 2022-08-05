import 'package:flutter/material.dart';
import '../../utilities/app_localizations.dart';
import '../../utilities/size_config.dart';

class AddressBox extends StatelessWidget {
  final bool selected;
  final bool isPickup;
  final String title;

  const AddressBox(
      {required this.selected, required this.isPickup, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Container(
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(7)),
              color: Theme.of(context).backgroundColor,
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context)
                      .colorScheme
                      .secondaryContainer
                      .withOpacity(0.3),
                  blurRadius: 6,
                  spreadRadius: 0.5,
                )
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      width: SizeConfig.screenWidth! - 110,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.place,
                            color: Theme.of(context).primaryColor,
                            size: 17.5,
                          ),
                          Container(
                            width: SizeConfig.screenWidth! - 130,
                            child: Text(
                              "${(AppLocalizations.of(context)!.tr(isPickup ? "pick_up_from" : 'delivery_to') + " ")} ${isPickup ? AppLocalizations.of(context)!.tr('soon') : title}",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1!
                                  .copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal),
                            ),
                          ),
                        ],
                      )),
                  Icon(
                    selected
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    color: Theme.of(context).textTheme.subtitle2!.color,
                    size: 35,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
