import 'package:flutter/material.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:new_turki/widgets/home/product_description.dart';
import 'package:new_turki/widgets/home/product_header.dart';
import 'package:new_turki/widgets/shared/rounded_rectangle_button.dart';
import 'package:new_turki/widgets/tags_list.dart';

class ProductDetails extends StatefulWidget {
  final int id;
  const ProductDetails({required this.id});
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool selected2 = true;
  bool selected3 = true;
  bool selected4 = true;
  bool selected = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          ProductHeader(
            imgList: [
              'https://media.istockphoto.com/photos/various-cuts-of-meat-shot-from-the-top-on-a-black-background-with-picture-id1214484853?k=20&m=1214484853&s=612x612&w=0&h=knuk2LWm9ZcKd6DsAWHURBD0wpqmnRwcI6Q1SRNtCtc=',
              'https://storage.googleapis.com/tm-zopsmart-uploads/320/20201031/210840_1-20201031-233123.png',
              'https://sc04.alicdn.com/kf/U0378557e32e4448f8263411cc91952014.png',
              'https://5.imimg.com/data5/MU/NR/MY-35620512/sirohi-goat-meat-500x500.png',
            ],
          ),
          ProductDescription(),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(15.0, 15.0, 0.0, 10.0),
            child: Text(
              'معلومات المنتج',
              style: Theme.of(context)
                  .textTheme
                  .headline4
                  ?.copyWith(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Column(
          //       children: [
          //         Padding(
          //           padding:
          //               EdgeInsetsDirectional.fromSTEB(15.0, 15.0, 0.0, 10.0),
          //           child: Text(
          //             'الوزن',
          //             style: Theme.of(context)
          //                 .textTheme
          //                 .headline4
          //                 ?.copyWith(fontSize: 14, fontWeight: FontWeight.bold),
          //           ),
          //         ),
          //         Padding(
          //           padding:
          //               EdgeInsetsDirectional.fromSTEB(15.0, 15.0, 0.0, 10.0),
          //           child: Text(
          //             'السعرت',
          //             style: Theme.of(context)
          //                 .textTheme
          //                 .headline4
          //                 ?.copyWith(fontSize: 14, fontWeight: FontWeight.bold),
          //           ),
          //         ),
          //       ],
          //     ),
          //     Column(
          //       children: [
          //         Padding(
          //           padding:
          //               EdgeInsetsDirectional.fromSTEB(15.0, 15.0, 0.0, 10.0),
          //           child: Text(
          //             'الوزن',
          //             style: Theme.of(context)
          //                 .textTheme
          //                 .subtitle1
          //                 ?.copyWith(fontSize: 14, fontWeight: FontWeight.bold),
          //           ),
          //         ),
          //         Padding(
          //           padding:
          //               EdgeInsetsDirectional.fromSTEB(15.0, 15.0, 0.0, 10.0),
          //           child: Text(
          //             'السعرت',
          //             style: Theme.of(context)
          //                 .textTheme
          //                 .headline4
          //                 ?.copyWith(fontSize: 14, fontWeight: FontWeight.bold),
          //           ),
          //         ),
          //       ],
          //     )
          //   ],
          // ),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    RoundedRectangleButton(
                      padding: EdgeInsets.all(0),
                      onPressed: () {
                        //   _cartProvider.removeItem(context, index);
                      },
                      width: 40,
                      height: 40,
                      fontSize: 22,
                      title: '-',
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "1",
                        style: Theme.of(context)
                            .textTheme
                            .headline1
                            ?.copyWith(fontSize: 16),
                      ),
                    ),
                    RoundedRectangleButton(
                      onPressed: () {
                        // _cartProvider.addItem(context, index);
                      },
                      padding: EdgeInsets.all(0),
                      width: 40,
                      height: 40,
                      fontSize: 22,
                      title: '+',
                    ),
                    RoundedRectangleButton(
                      onPressed: () {
                        // _cartProvider.addItem(context, index);
                      },
                      padding: EdgeInsets.all(0),
                      width: SizeConfig.screenWidth! - 150,
                      height: 40,
                      fontSize: 15,
                      title: 'اضف للسلة',
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
