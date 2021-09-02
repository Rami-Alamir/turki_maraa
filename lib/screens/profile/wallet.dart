import 'package:flutter/material.dart';
import 'package:new_turki/models/wallet.dart';
import 'package:new_turki/utilities/behavior.dart';
import 'package:new_turki/utilities/r_a1_i_c_o_n_s_icons.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:new_turki/widgets/primary_app_bar.dart';
import 'package:new_turki/widgets/profile/transaction_row.dart';

class UserWallet extends StatefulWidget {
  const UserWallet({Key? key}) : super(key: key);

  @override
  _UserWalletState createState() => _UserWalletState();
}

class _UserWalletState extends State<UserWallet> {
  List<Wallet> list = [
    Wallet(
        sId: '1',
        before: 100,
        color: Colors.green,
        iconData: RA1ICONS.money__1_,
        after: 35,
        description: 'اضافة أموال',
        userId: '1'),
    Wallet(
        sId: '1',
        color: Colors.red,
        iconData: RA1ICONS.money__2_,
        before: 65,
        after: -185,
        description: 'سداد قيمة الطلب ٥٠٨٠٧',
        userId: '1'),
    Wallet(
        sId: '200',
        color: Colors.purple,
        iconData: RA1ICONS.badge,
        before: 250,
        after: 50,
        description: 'استبدال نقاط',
        userId: '1'),
    Wallet(
        sId: '200',
        color: Colors.green,
        iconData: RA1ICONS.gift,
        before: 200,
        after: 200,
        description: 'اضافة رصيد هدية',
        userId: '1'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(
        back: true,
        title: 'المحفظة',
      ),
      body: ScrollConfiguration(
        behavior: Behavior(),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 0.0),
          child: CustomScrollView(
            slivers: <Widget>[
              SliverList(
                  delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: const EdgeInsets.only(top: 60.0, bottom: 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '100',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1!
                                  .copyWith(fontSize: 40, color: Colors.black),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                'ريال',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .copyWith(
                                        fontSize: 14, color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'رصيدك الحالي',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(
                                  fontSize: 12,
                                  color: Theme.of(context).primaryColor),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 5),
                    child: Text(
                      'اضافة رصيد',
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.headline1!.copyWith(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Card(
                          elevation: 500,
                          shadowColor: Colors.grey.withOpacity(0.1),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          child: Container(
                            width: SizeConfig.screenWidth! * 0.45,
                            height: 100,
                            child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(const Radius.circular(5)),
                                child: Container(
                                    constraints: BoxConstraints(minHeight: 100),
                                    width: SizeConfig.screenWidth! * 045,
                                    color: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 10),
                                      child: Container(
                                        height: 77,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Icon(
                                                Icons.card_giftcard,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                            ),
                                            Text(
                                              'اضف بطاقة هدايا',
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline1!
                                                  .copyWith(
                                                    fontSize: 12,
                                                    color: Colors.black,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ))),
                          ),
                        ),
                        Card(
                          elevation: 500,
                          shadowColor: Colors.grey.withOpacity(0.1),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          child: Container(
                            width: SizeConfig.screenWidth! * 0.45,
                            height: 100,
                            child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(const Radius.circular(5)),
                                child: Container(
                                    constraints: BoxConstraints(minHeight: 100),
                                    width: SizeConfig.screenWidth! * 045,
                                    color: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 10),
                                      child: Container(
                                        height: 77,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Icon(
                                                Icons.credit_card,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                            ),
                                            Text(
                                              'إضافة الأموال',
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline1!
                                                  .copyWith(
                                                    fontSize: 12,
                                                    color: Colors.black,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ))),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'تفاصيل العمليات',
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.headline1!.copyWith(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: list.length,
                      padding: EdgeInsets.all(0),
                      itemBuilder: (BuildContext ctxt, int index) {
                        return TransactionRow(
                          transaction: list[index],
                        );
                      })
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
