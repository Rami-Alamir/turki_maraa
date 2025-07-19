import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/profile/wallet/transaction_row.dart';
import '../../widgets/profile/wallet/wallet_header.dart';
import '../../widgets/shared/page_builder.dart';
import '../../widgets/shared/primary_app_bar.dart';
import '../../../controllers/user_provider.dart';
import '../../../controllers/location_provider.dart';
import '../../../core/service/service_locator.dart';
import '../../../core/utilities/get_strings.dart';
import '../../../core/utilities/app_localizations.dart';

class UserWallet extends StatefulWidget {
  const UserWallet({super.key});

  @override
  UserWalletState createState() => UserWalletState();
}

class UserWalletState extends State<UserWallet> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      if (!mounted) return;
      await context.read<UserProvider>().getWallet();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(
        back: true,
        title: AppLocalizations.of(context)!.tr('credit'),
      ),
      body: Consumer<UserProvider>(
        builder: (_, userProvider, _) {
          final LocationProvider locationProvider =
              Provider.of<LocationProvider>(context, listen: false);
          final String currency = sl<GetStrings>().getCurrency(
            AppLocalizations.of(context)!.locale!.languageCode,
            locationProvider.isoCountryCode!,
          );
          return PageBuilder(
            requestStatus: userProvider.requestStatus,
            onError: () async {
              userProvider.getWallet(withNotify: true);
            },
            child: RefreshIndicator(
              color: Theme.of(context).colorScheme.primary,
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              onRefresh: () async {
                await userProvider.getWallet();
              },
              child: ListView(
                children: [
                  WalletHeader(currency: currency),
                  if ((userProvider.wallet?.data?.walletLogs?.length ?? 0) >
                      0) ...[
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        AppLocalizations.of(context)!.tr('transaction_details'),
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.displayLarge!
                            .copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount:
                          (userProvider.wallet?.data?.walletLogs?.length ?? 0),
                      padding: const EdgeInsets.all(0),
                      itemBuilder: (_, int index) {
                        return TransactionRow(
                          transaction:
                              userProvider.wallet!.data!.walletLogs![index],
                          currency: currency,
                        );
                      },
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
