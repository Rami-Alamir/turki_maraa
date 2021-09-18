import 'package:flutter/material.dart';
import 'package:new_turki/models/item.dart';
import 'package:new_turki/screens/cart/invoice.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:new_turki/widgets/order_details_row.dart';
import 'package:new_turki/widgets/primary_app_bar.dart';
import 'package:new_turki/widgets/shared/main_card.dart';
import 'package:new_turki/widgets/timeline/indicator.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({Key? key}) : super(key: key);

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(
        title: 'تفاصيل الطلب',
      ),
      body: ListView(
        children: [
          MainCard(
            height: 235,
            child: Container(
              height: 150,
              width: SizeConfig.screenWidth!,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          'رقم الطلب: 54698#',
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            10.0, 10.0, 0.0, 0.0),
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: SizeConfig.screenWidth! * .9 - 15,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'تاريخ التوصيل',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline5!
                                                .copyWith(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                ),
                                          ),
                                          Text(
                                            '10/09/2021',
                                            style: TextStyle(
                                                height: 1.6,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10,
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            'فترة التوصيل',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline5!
                                                .copyWith(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                ),
                                          ),
                                          Text(
                                            'فترة الظهر',
                                            style: TextStyle(
                                                height: 1.6,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10,
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Container(
                                  width: SizeConfig.screenWidth! * .9 - 15,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'تاريخ الطلب',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5!
                                                  .copyWith(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
                                                  ),
                                            ),
                                            Text(
                                              '1/9/2021',
                                              style: TextStyle(
                                                  height: 1.6,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 10,
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              'النقاط المكتسبة',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5!
                                                  .copyWith(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
                                                  ),
                                            ),
                                            Text(
                                              '4000 نقطة',
                                              style: TextStyle(
                                                  height: 1.6,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 10,
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Indicator(
                          title: 'تم تأكيد الطلب',
                          color: Theme.of(context).primaryColor,
                          color2: Theme.of(context).primaryColor,
                          icon: Icons.confirmation_num_outlined,
                        ),
                        Indicator(
                          title: 'جاري التجهيز',
                          color: Theme.of(context).primaryColor,
                          color2: Theme.of(context).primaryColor,
                          icon: Icons.sync_problem_sharp,
                        ),
                        Indicator(
                          title: 'اختبار الجودة',
                          color: Theme.of(context).primaryColor,
                          color2: Colors.amber,
                          icon: Icons.fact_check_outlined,
                        ),
                        Indicator(
                          title: 'جاري التوصيل',
                          color: Colors.amber,
                          color2: Colors.grey,
                          icon: Icons.delivery_dining,
                        ),
                        Indicator(
                          withLine: false,
                          title: 'تم التوصيل',
                          color: Colors.grey,
                          color2: Colors.grey,
                          icon: Icons.done_all,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
            child: Text(
              'عنوان التوصيل',
              style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ),
          MainCard(
            height: 50,
            child: Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.location_pin, color: Theme.of(context).primaryColor),
                Text(' الياسمين طريق الملك عبدالعزيز',
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        )),
              ],
            )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
            child: Text(
              'طريقة الدفع',
              style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ),
          MainCard(
            height: 50,
            child: Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/images/applepay.png',
                    width: 35,
                    height: 35,
                  ),
                ),
                Text(' أبل باي',
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        )),
              ],
            )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
            child: Text(
              'تفاصيل الطلب',
              style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ),
          MainCard(
            height: 520,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(right: 15.0, top: 20, bottom: 10),
                  child: Text(
                    'عدد الاصناف (4)',
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                  ),
                ),
                OrderDetailsRow(
                    subtitle: 'نعيمي هرفي صغير - تقطيع ثلاجة - فاكيوم',
                    item: Item(
                        image:
                            'https://cdn.salla.sa/dbPPv/ArNOJzNYSAzorMhVAEw2CVWu8Zid2tdadfIDhfr9.jpg',
                        price: 1850,
                        title: '1x نعيمي ')),
                OrderDetailsRow(
                    subtitle: '',
                    item: Item(
                        image:
                            'https://cdn.salla.sa/7Uv2ZnbDos0fZoX1fUSQMWKDq7mYxezM8kvh1wqt.jpeg',
                        price: 60,
                        title: '1x برجر ')),
                OrderDetailsRow(
                    subtitle: '',
                    item: Item(
                        image:
                            'https://cdn.salla.sa/8tbiQBKYSSj9cjQLKgUxecpAVcaLbOXM3i5KICD8.jpeg',
                        price: 190,
                        title: '2x ريش غنم ')),
                Invoice(
                  myCredit: 50,
                  subtotal: 2100,
                  total: 2060,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
