import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../controllers/location_provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/service/service_locator.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../controllers/cart_provider.dart';
import '../../../core/utilities/get_strings.dart';

class UseCredit extends StatelessWidget {
  const UseCredit({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final CartProvider cartProvider = Provider.of<CartProvider>(context);
    final String credit = cartProvider.userData?.data?.wallet ?? "0.0";
    final LocationProvider locationProvider =
        Provider.of<LocationProvider>(context, listen: false);
    String currency = sl<GetStrings>().getCurrency(
        AppLocalizations.of(context)!.locale!.languageCode,
        locationProvider.isoCountryCode!);
    return Visibility(
      visible: double.parse(credit) > 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 3, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: cartProvider.useCredit,
                      fillColor: MaterialStateProperty.all(
                          Theme.of(context).primaryColor),
                      checkColor: AppColors.white, // color of tick Mark
                      activeColor:
                          Theme.of(context).textTheme.displayLarge!.color!,
                      onChanged: (bool? value) {
                        HapticFeedback.heavyImpact();
                        cartProvider.useCredit = value!;
                      },
                    ),
                    RichText(
                      text: TextSpan(
                          text:
                              AppLocalizations.of(context)!.tr('use_my_credit'),
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(fontSize: 12, height: 3),
                          children: <TextSpan>[
                            TextSpan(
                              text: ' ($credit $currency)',
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(fontSize: 12, height: 3),
                            )
                          ]),
                    ), //Checkbox
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
