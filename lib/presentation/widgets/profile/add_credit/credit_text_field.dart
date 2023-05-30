import 'package:flutter/material.dart';
import '../../shared/main_card.dart';
import '../../../../core/utilities/app_localizations.dart';

class CreditTextField extends StatelessWidget {
  const CreditTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainCard(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: SizedBox(
        height: 115,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                AppLocalizations.of(context)!.tr('amount'),
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(fontSize: 14),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                cursorColor: Theme.of(context).primaryColor,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  suffixIcon: Text(
                    AppLocalizations.of(context)!.tr('sr'),
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontSize: 14, height: 2.5),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color:
                            Theme.of(context).colorScheme.secondaryContainer),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
