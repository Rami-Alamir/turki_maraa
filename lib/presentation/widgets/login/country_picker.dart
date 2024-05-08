import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controllers/auth.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/country_utils.dart';
import '../../../models/country.dart';

class CountryPicker extends StatelessWidget {
  CountryPicker({super.key});
  final List<Country> countries = CountryUtils.countries;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        backgroundColor: Theme.of(context).colorScheme.onBackground,
        contentPadding: const EdgeInsets.all(0),
        content: Builder(
          builder: (context) {
            return Container(
              constraints: const BoxConstraints(maxWidth: 500, minWidth: 300),
              height: 120,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 120,
                    width: 400,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: const ScrollPhysics(),
                        itemCount: countries.length,
                        padding:
                            const EdgeInsets.only(right: 15, left: 15, top: 25),
                        itemBuilder: (BuildContext ctxt, int index) {
                          return InkWell(
                            onTap: () {
                              context.read<Auth>().updateCountry(
                                  countries[index].dialCode,
                                  countries[index].isoCountryCode);
                              Navigator.of(context).pop();
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 3.0),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 8.0, left: 8),
                                    child: Text(
                                      countries[index].flag,
                                      style: const TextStyle(fontSize: 25),
                                    ),
                                  ),
                                  Text(
                                    countries[index].dialCode,
                                    textDirection: TextDirection.ltr,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Text(
                                      AppLocalizations.of(context)!
                                                  .locale!
                                                  .languageCode ==
                                              'ar'
                                          ? countries[index].nameAr
                                          : countries[index].nameEn,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
