import 'package:flutter/material.dart';
import 'package:new_turki/widgets/image_slider2.dart';
import 'package:new_turki/widgets/rounded_rectangle_button.dart';
import 'package:new_turki/widgets/tags_list.dart';

class ItemDetails extends StatefulWidget {
  final String name;

  const ItemDetails({this.name = ''});

  @override
  _ItemDetailsState createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  bool selected = true;
  bool selected2 = true;
  bool selected3 = true;
  @override
  Widget build(BuildContext context) {
    Scaffold.of(context).openEndDrawer();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).primaryColor,
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      // bottomNavigationBar: Container(
      //   height: 90,
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: [
      //       Padding(
      //         padding: const EdgeInsetsDirectional.fromSTEB(20.0, 0, 20, 0),
      //         child: Row(
      //           children: [
      //             Row(
      //               children: [
      //                 Row(
      //                   children: [
      //                     RoundedRectangleButton(
      //                       padding: EdgeInsets.all(0),
      //                       onPressed: () {},
      //                       width: 35,
      //                       height: 35,
      //                       fontSize: 22,
      //                       title: '-',
      //                     ),
      //                     Text(
      //                       '1',
      //                       style: Theme.of(context)
      //                           .textTheme
      //                           .headline1
      //                           ?.copyWith(fontSize: 16),
      //                     ),
      //                     RoundedRectangleButton(
      //                       onPressed: () {},
      //                       padding: EdgeInsets.all(0),
      //                       width: 35,
      //                       height: 35,
      //                       fontSize: 22,
      //                       title: '+',
      //                     )
      //                   ],
      //                 )
      //               ],
      //             )
      //           ],
      //         ),
      //       ),
      //       RoundedRectangleButton(
      //         padding: const EdgeInsets.symmetric(horizontal: 15.0),
      //         onPressed: () {},
      //         width: MediaQuery.of(context).size.width / 2.1,
      //         height: 35,
      //         fontSize: 14,
      //         title: 'اضف للسلة',
      //       )
      //     ],
      //   ),
      // ),
      body: ListView(
        padding: EdgeInsets.all(0),
        children: [
          true
              ? Hero(
                  tag: widget.name,
                  child: ImageSlider2(imgList: [
                    "https://shababalfreej.com/image/cache/catalog/products/NAIMI/e3fe095b-f29e-43f6-b97f-f071f20eb6da-removebg-preview-547x456.png",
                    'https://storage.googleapis.com/tm-zopsmart-uploads/320/20201031/210840_1-20201031-233123.png',
                    'https://sc04.alicdn.com/kf/U0378557e32e4448f8263411cc91952014.png',
                    'https://5.imimg.com/data5/MU/NR/MY-35620512/sirohi-goat-meat-500x500.png',
                  ]),
                )
              : ImageSlider2(imgList: [
                  "https://shababalfreej.com/image/cache/catalog/products/NAIMI/e3fe095b-f29e-43f6-b97f-f071f20eb6da-removebg-preview-547x456.png",
                  'https://storage.googleapis.com/tm-zopsmart-uploads/320/20201031/210840_1-20201031-233123.png',
                  'https://sc04.alicdn.com/kf/U0378557e32e4448f8263411cc91952014.png',
                  'https://5.imimg.com/data5/MU/NR/MY-35620512/sirohi-goat-meat-500x500.png',
                ]),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'نعيمي',
                  style: Theme.of(context).textTheme.headline1,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            '1850',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          Text(
                            'ريال',
                            style:
                                Theme.of(context).textTheme.subtitle1?.copyWith(
                                      fontSize: 16,
                                    ),
                          ),
                        ],
                      ),
                      Text(
                        '(شامل ضريبة القيمة المضافة)',
                        style: Theme.of(context).textTheme.headline6?.copyWith(
                            fontSize: 10, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Text(
                    'خروف نعيمي بلدي مربى محليا في مزارعنا يصلك طازج ومغلف ومقطع حسب اختيارك',
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(height: 1.5),
                    textAlign: TextAlign.justify,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                'assets/images/star.png',
                                width: 20,
                                height: 20,
                              ),
                            ),
                            Text(
                              '4.9',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                            )
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              'assets/images/weight.png',
                              width: 20,
                              height: 20,
                            ),
                          ),
                          Text(
                            '18-20 كيلو',
                            style: Theme.of(context)
                                .textTheme
                                .headline1!
                                .copyWith(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                'assets/images/fire.png',
                                width: 20,
                                height: 20,
                              ),
                            ),
                            Text(
                              '4000 سعرة حرارية',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: TagsList(
              title: 'الحجم',
              tags: [
                'جذع صغير',
                'جذع وسط',
              ],
              isSelected: [
                selected,
                !selected,
              ],
              onTap: () {
                setState(() {
                  selected = !selected;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: TagsList(
              title: 'التقطيع',
              tags: [
                'كاملة',
                'ثلاجة',
              ],
              isSelected: [
                selected2,
                !selected2,
              ],
              onTap: () {
                setState(() {
                  selected2 = !selected2;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: TagsList(
              title: 'التغليف',
              tags: [
                'أكياس فاكيوم',
                'أطباق',
              ],
              isSelected: [
                selected3,
                !selected3,
              ],
              onTap: () {
                setState(() {
                  selected3 = !selected3;
                });
              },
            ),
          ),
          Container(
            height: 90,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(20.0, 0, 20, 0),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          Row(
                            children: [
                              RoundedRectangleButton(
                                padding: EdgeInsets.all(0),
                                onPressed: () {},
                                width: 35,
                                height: 35,
                                fontSize: 22,
                                title: '-',
                              ),
                              Text(
                                '1',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1
                                    ?.copyWith(fontSize: 16),
                              ),
                              RoundedRectangleButton(
                                onPressed: () {},
                                padding: EdgeInsets.all(0),
                                width: 35,
                                height: 35,
                                fontSize: 22,
                                title: '+',
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
                RoundedRectangleButton(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  onPressed: () {},
                  width: MediaQuery.of(context).size.width / 2.1,
                  height: 35,
                  fontSize: 14,
                  title: 'اضف للسلة',
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
