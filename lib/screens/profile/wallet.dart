import 'package:flutter/material.dart';
import 'package:new_turki/dummy_data/dummy_data.dart';
import 'package:new_turki/provider/auth.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/widgets/profile/transaction_row.dart';
import 'package:new_turki/widgets/profile/wallet_header.dart';
import 'package:new_turki/widgets/shared/primary_app_bar.dart';
import 'package:provider/provider.dart';

class UserWallet extends StatefulWidget {
  @override
  _UserWalletState createState() => _UserWalletState();
}

class _UserWalletState extends State<UserWallet> {
  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<Auth>(context);
    return Scaffold(
        appBar: PrimaryAppBar(
          back: true,
          title: AppLocalizations.of(context)!.tr('credit'),
        ),
        body: ListView(
          children: [
            WalletHeader(credit: _auth.user.credit!),
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
            ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: DummyData.walletList.length,
                padding: EdgeInsets.all(0),
                itemBuilder: (BuildContext ctxt, int index) {
                  return TransactionRow(
                    transaction: DummyData.walletList[index],
                  );
                })
          ],
        ));
  }
}
