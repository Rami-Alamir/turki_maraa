import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../../controllers/app_provider.dart';
import '../../../controllers/user_provider.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/constants/fixed_assets.dart';

class GiftDialog extends StatelessWidget {
  const GiftDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final UserProvider user = Provider.of<UserProvider>(context);
    final AppProvider appProvider = Provider.of<AppProvider>(context);
    final bool isAr =
        AppLocalizations.of(context)!.locale!.languageCode == 'ar';
    final String title =
        "${isAr ? appProvider.promotion?.titleAr : appProvider.promotion?.titleEn} ${user.userData?.data?.name}";
    final String subtitle =
        "${isAr ? appProvider.promotion?.subTitleAr : appProvider.promotion?.subTitleEn}";
    return SizedBox(
      width: 100,
      child: AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        backgroundColor: Theme.of(context).colorScheme.onSurface,
        contentPadding: const EdgeInsets.all(0),
        content: Builder(
          builder: (context) {
            return Container(
              constraints: const BoxConstraints(maxWidth: 500, minWidth: 300),
              height: 400,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(12, 0, 10, 20),
                    child: Lottie.asset(
                        appProvider.canShakeToday
                            ? FixedAssets.congratulations
                            : FixedAssets.spin,
                        width: 200,
                        height: 200),
                  ),
                  Text(
                    appProvider.canShakeToday
                        ? title
                        : AppLocalizations.of(context)!
                            .tr('you_are_exhausted_today'),
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(fontSize: 18, height: 1),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 8.0, right: 20, left: 20),
                    child: Text(
                      appProvider.canShakeToday
                          ? subtitle
                          : AppLocalizations.of(context)!
                              .tr('try_tomorrow_and_try_every_day_and_win'),
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontSize: 14),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
