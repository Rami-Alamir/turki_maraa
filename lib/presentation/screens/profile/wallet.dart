import 'package:flutter/material.dart';
import '../../widgets/profile/wallet_header.dart';
import '../../widgets/shared/primary_app_bar.dart';
import '../../../core/utilities/app_localizations.dart';

//This feature will be active soon
class UserWallet extends StatefulWidget {
  const UserWallet({Key? key}) : super(key: key);

  @override
  UserWalletState createState() => UserWalletState();
}

class UserWalletState extends State<UserWallet> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PrimaryAppBar(
          back: true,
          title: AppLocalizations.of(context)!.tr('credit'),
        ),
        body: RefreshIndicator(
          color: Theme.of(context).primaryColor,
          backgroundColor: Theme.of(context).colorScheme.secondary,
          onRefresh: () async {},
          child: ListView(
            children: [
              const WalletHeader(credit: 100),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  AppLocalizations.of(context)!.tr('transaction_details'),
                  textAlign: TextAlign.start,
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
              //     ListView.builder(
              //         shrinkWrap: true,
              //         scrollDirection: Axis.vertical,
              //         physics: const NeverScrollableScrollPhysics(),
              //         itemCount: DummyData.walletList.length,
              //         padding: EdgeInsets.all(0),
              //         itemBuilder: (BuildContext ctxt, int index) {
              //           return TransactionRow(
              //             transaction: DummyData.walletList[index],
              //           );
              //         })
            ],
          ),
        ));
  }
}
