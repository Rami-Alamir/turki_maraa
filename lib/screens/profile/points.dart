import 'package:flutter/material.dart';
import 'package:new_turki/models/item.dart';
import 'package:new_turki/models/point.dart';
import 'package:new_turki/models/wallet.dart';
import 'package:new_turki/utilities/behavior.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:new_turki/widgets/points_card.dart';
import 'package:new_turki/widgets/primary_app_bar.dart';
import 'package:new_turki/widgets/profile/transaction_row2.dart';

class UserPoints extends StatefulWidget {
  const UserPoints({Key? key}) : super(key: key);

  @override
  _UserPointsState createState() => _UserPointsState();
}

class _UserPointsState extends State<UserPoints> {
  final List<Item> itemList7 = [
    Item(
        image:
            'https://i.insider.com/5a5313e8c32ae61f008b4e78?width=1200&format=jpeg',
        price: 5000,
        title: 'استبدل ب ٥٠ ريال رصيد'),
    Item(
        image:
            'https://d.newsweek.com/en/full/1608695/newsweek-amplify-money-rewards-weight-loss.png',
        price: 9500,
        title: 'استبدل ب 100 ريال رصيد'),
    Item(
        image:
            'https://www.al-madina.com/uploads/images/2021/04/20/1882664.jpg',
        price: 4000,
        title: 'تبرع لجمعة جود'),
    Item(
        image:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQsUMKOybQvnZpcVZNoLQ9gR5c94P5K7qDsE1UJ6tudSHnWDilW27S2kliLFe4CxzcTcS0&usqp=CAU',
        price: 12000,
        title: 'كيلو ستيك'),
  ];
  List<Point> list = [
    Point(
        image: "assets/images/medal.png",
        sId: '1',
        before: 500,
        after: 500,
        description: 'اضافة ٥٠٠ نقطة عن الطلب رقم ٥٤٥٤٣',
        userId: '1'),
    Point(
        image: "assets/images/money.png",
        sId: '1',
        before: 0,
        after: -500,
        description: 'استبدال برصيد',
        userId: '1'),
    Point(
        image: "assets/images/medal.png",
        sId: '500',
        before: 500,
        after: 500,
        description: 'اضافة ٥٠٠ نقطة هدية',
        userId: '1'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(
        back: true,
        title: 'نقاطي',
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
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      elevation: 8,
                      shadowColor: Colors.grey.withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      child: ClipRRect(
                          borderRadius:
                              BorderRadius.all(const Radius.circular(10)),
                          child: Container(
                              width: SizeConfig.screenWidth! * 0.45,
                              height: 165,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/images/w.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              // decoration: BoxDecoration(
                              //
                              //   // gradient: LinearGradient(
                              //   //   begin: Alignment.topRight,
                              //   //   end: Alignment.bottomLeft,
                              //   //   colors: [
                              //   //     Color.fromRGBO(112, 112, 112, 1),
                              //   //     Color.fromRGBO(133, 133, 133, 1),
                              //   //   ],
                              //   ),

                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Text(
                                          '5400',
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline1!
                                              .copyWith(
                                                  fontSize: 26,
                                                  color: Colors.white),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(
                                            'نقطة',
                                            textAlign: TextAlign.center,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline1!
                                                .copyWith(
                                                    fontSize: 14,
                                                    color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: <Widget>[
                                            Icon(
                                              Icons.workspaces_filled,
                                              color: Colors.white,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Text(
                                                'الفئة الفضية',
                                                textAlign: TextAlign.start,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline1!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: 12,
                                                        color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Container(
                                            width: SizeConfig.screenWidth! * .6,
                                            child: Text(
                                              'احصل على مزايا ومكافات حصرية عند حصولك على ١٤٥٠ نقطة و ترقيتك للفئة الذهبية',
                                              textAlign: TextAlign.start,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline1!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 10,
                                                      color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 10),
                    child: Text(
                      'استبدل بالمكافات',
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.headline1!.copyWith(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: SizeConfig.screenWidth,
                        height: 200,
                        child: ListView.builder(
                            padding: EdgeInsets.all(0),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            physics: ScrollPhysics(),
                            itemCount: itemList7.length,
                            itemBuilder: (BuildContext ctxt, int index) {
                              return Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    index == 0 ? 8 : 3.0, 0, 0, 0),
                                child: PointsCard(item: itemList7[index]),
                              );
                            }),
                      ),
                    ],
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
                        return TransactionRow2(
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
