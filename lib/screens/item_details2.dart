import 'package:flutter/material.dart';
import 'package:new_turki/widgets/rounded_rectangle_button.dart';
import 'package:new_turki/widgets/tag.dart';
import 'package:new_turki/widgets/tags_list.dart';
import '../widgets/image_slider.dart';
import '../widgets/primary_app_bar.dart';

class ItemDetails2 extends StatefulWidget {
  const ItemDetails2({Key? key}) : super(key: key);

  @override
  _ItemDetails2State createState() => _ItemDetails2State();
}

class _ItemDetails2State extends State<ItemDetails2> {
  bool selected = false;
  bool selected2 = false;
  bool selected3 = false;

  @override
  Widget build(BuildContext context) {
    Scaffold.of(context).openEndDrawer();
    return Scaffold(
      appBar: PrimaryAppBar(),
      bottomNavigationBar: Container(
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
      body: ListView(
        padding: EdgeInsets.all(0),
        children: [
          ImageSlider(imgList: [
            "https://flyingcdn-e5230a.b-cdn.net/wp-content/uploads/2021/02/image.jpeg",
            'https://storage.googleapis.com/tm-zopsmart-uploads/320/20201031/210840_1-20201031-233123.png',
            'https://sc04.alicdn.com/kf/U0378557e32e4448f8263411cc91952014.png',
            'https://5.imimg.com/data5/MU/NR/MY-35620512/sirohi-goat-meat-500x500.png',
          ]),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'نعيمي',
                  style: Theme.of(context).textTheme.subtitle1,
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
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                ?.copyWith(color: Colors.black),
                          ),
                          Text(
                            'ريال',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                ?.copyWith(fontSize: 16, color: Colors.black),
                          ),
                        ],
                      ),
                      Text(
                        '(شامل ضريبة القيمة المضافة)',
                        style: Theme.of(context).textTheme.subtitle1?.copyWith(
                            color: Colors.grey,
                            fontSize: 10,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Text(
                    'ذبيحة كاملة مع الكوارع والكبده والراس مغلفة ومقطعه حسب اختيارك',
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(height: 1.5),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
          ),
          TagsList(
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
        ],
      ),
    );
  }
}
