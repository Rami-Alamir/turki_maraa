import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controllers/cart_provider.dart';
import '../../../controllers/app_provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/size_config.dart';
import '../../../models/cart_data.dart';

class DayOfSacrifice extends StatelessWidget {
  final List<DateTime> deliveryDataTime;
  const DayOfSacrifice({
    super.key,
    required this.deliveryDataTime,
  });
  @override
  Widget build(BuildContext context) {
    final List<String> days = [
      AppLocalizations.of(context)!.tr('first_day'),
      AppLocalizations.of(context)!.tr('second_day'),
      AppLocalizations.of(context)!.tr('third_day'),
      AppLocalizations.of(context)!.tr('fourth_day'),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 15.0, top: 30, left: 15),
          child: Text(
            AppLocalizations.of(context)!.tr('choose_the_day_of_sacrifice'),
            style: Theme.of(context)
                .textTheme
                .displayLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          width: SizeConfig.screenWidth,
          height: 122,
          child: ListView.builder(
              padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: const ScrollPhysics(),
              itemCount: 4,
              itemBuilder: (BuildContext ctxt, int index) {
                return
                    // Visibility(
                    // visible: checkDate(
                    //     notIncludedDates,
                    //     context.read<AppProvider>().adhaConfig?.dates?[index] ??
                    //         ""),
                    // child:
                    Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(3.0, 15, 10, 0),
                  child: _item(
                    context,
                    index,
                    days[index],
                    // ),
                  ),
                );
              }),
        ),
      ],
    );
  }

  bool checkDate(List<NotIncludedDates> notIncludedDates, String date) {
    bool status = true;
    for (int i = 0; i < notIncludedDates.length; i++) {
      if (date.trim() == notIncludedDates[i].deliveryDate!.trim()) return false;
    }
    return status;
  }

  Widget _item(BuildContext context, int selectedValue, String title) {
    final CartProvider cartProvider =
        Provider.of<CartProvider>(context, listen: false);
    final bool selected = cartProvider.selectedDate == selectedValue;
    return InkWell(
      onTap: () {
        cartProvider.setSelectedDate = selectedValue;
      },
      child: Container(
        width: 80,
        padding: const EdgeInsets.all(3.0),
        constraints: const BoxConstraints(
          minHeight: 50,
        ),
        decoration: BoxDecoration(
            color: selected
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.outline,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0, left: 8, top: 0),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    height: 2,
                    color: selected
                        ? AppColors.white
                        : Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .color!
                            .withOpacity(0.6)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
