import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../../../../controllers/home_provider.dart';
import '../../../../core/utilities/app_localizations.dart';
import '../../../../core/utilities/size_config.dart';

class OrderTypeItem extends StatelessWidget {
  final int type;
  final String title;
  final IconData icon;
  const OrderTypeItem(
      {super.key, required this.type, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (_, homeProvider, __) {
      bool selected = homeProvider.selectedOrderType == type;
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: InkWell(
          onTap: () {
            homeProvider.setOrderType = type;
          },
          child: Container(
            padding: const EdgeInsets.all(3.0),
            width: SizeConfig.screenWidth! / 2 - 30,
            height: 87,
            constraints: const BoxConstraints(
              minHeight: 75,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color: selected
                        ? Theme.of(context).colorScheme.secondary
                        : Theme.of(context).colorScheme.secondaryContainer,
                    width: selected ? 1 : 0.8)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(6.0, 0, 8, 0),
                  child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .outline
                              .withOpacity(0.16),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(25))),
                      child: Icon(
                        icon,
                        size: 17.5,
                        color: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(selected ? 1 : 0.5),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: SizedBox(
                    width: SizeConfig.screenWidth! / 2 - 95,
                    child: AutoSizeText(
                      AppLocalizations.of(context)!.tr(title),
                      maxLines: 2,
                      minFontSize: 8,
                      maxFontSize: 12,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .color!
                              .withOpacity(selected ? 1 : 0.5),
                          height: 2.5),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
