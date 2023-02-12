import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turki_dabayh/core/constants/app_colors.dart';
import '../../../controllers/home_provider.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/size_config.dart';

class OrderTypeItem extends StatelessWidget {
  final int type;
  final String title;
  final IconData icon;
  const OrderTypeItem(
      {Key? key, required this.type, required this.title, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeProvider homeProvider = Provider.of<HomeProvider>(context);
    bool selected = homeProvider.selectedOrderType == type;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: InkWell(
        onTap: () {
          homeProvider.setOrderType = type;
        },
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
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
                      ? AppColors.yellow2
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
                            .primaryContainer
                            .withOpacity(0.16),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(25))),
                    child: Icon(
                      icon,
                      size: 17.5,
                      color: AppColors.yellow2.withOpacity(selected ? 1 : 0.5),
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
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                        fontSize: 12,
                        color:
                            AppColors.yellow2.withOpacity(selected ? 1 : 0.5),
                        fontWeight: FontWeight.normal,
                        height: 2.5),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
