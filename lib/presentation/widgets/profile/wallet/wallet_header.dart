import 'package:flutter/material.dart';
import '../../../../core/service/service_locator.dart';
import '../../../../core/utilities/app_localizations.dart';
import '../../../../core/utilities/get_strings.dart';
import '../../../../core/utilities/size_config.dart';
import 'package:provider/provider.dart';
import '../../../../controllers/location_provider.dart';

class WalletHeader extends StatelessWidget {
  final double credit;

  const WalletHeader({Key? key, required this.credit}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final LocationProvider locationProvider =
        Provider.of<LocationProvider>(context, listen: false);
    String currency = sl<GetStrings>().getCurrency(
        AppLocalizations.of(context)!.locale!.languageCode,
        locationProvider.isoCountryCode!);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 60.0, bottom: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    credit.toString(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge!
                        .copyWith(fontSize: 40),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      currency,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge!
                          .copyWith(fontSize: 14),
                    ),
                  ),
                ],
              ),
              Text(
                AppLocalizations.of(context)!.tr('your_current_balance'),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    fontSize: 12, color: Theme.of(context).primaryColor),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              addCreditCard(
                  context, 'add_credit', Icons.credit_card, "/AddCredit"),
              addCreditCard(context, 'add_a_gift_card', Icons.card_giftcard,
                  "/AddGiftCard")
            ],
          ),
        ),
      ],
    );
  }

  Widget addCreditCard(
      BuildContext context, String title, IconData icon, String routeName) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, routeName),
      child: Card(
        elevation: 0.3,
        shadowColor:
            Theme.of(context).textTheme.headlineMedium!.color!.withOpacity(0.6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        child: SizedBox(
          width: SizeConfig.screenWidth! * 0.45,
          height: 100,
          child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              child: Container(
                  constraints: const BoxConstraints(minHeight: 100),
                  width: SizeConfig.screenWidth! * 045,
                  color: Theme.of(context).colorScheme.secondary,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10),
                    child: SizedBox(
                      height: 77,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              icon,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          Text(
                            AppLocalizations.of(context)!.tr(title),
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge!
                                .copyWith(
                                  fontSize: 12,
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
