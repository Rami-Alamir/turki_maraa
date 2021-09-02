import 'package:flutter/material.dart';
import 'package:new_turki/models/item.dart';
import 'package:new_turki/utilities/behavior.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:new_turki/widgets/banners.dart';
import 'package:new_turki/widgets/item_card.dart';
import 'package:new_turki/widgets/primary_app_bar.dart';

class HomeFood extends StatefulWidget {
  const HomeFood({Key? key}) : super(key: key);

  @override
  _HomeFoodState createState() => _HomeFoodState();
}

class _HomeFoodState extends State<HomeFood> {
  HeroController? _heroController;

  final List<Item> itemList = [
    Item(
        image:
            'https://cdn.salla.sa/dbPPv/ArNOJzNYSAzorMhVAEw2CVWu8Zid2tdadfIDhfr9.jpg',
        price: 1850,
        title: 'نعيمي'),
    Item(
        image:
            'https://cdn.salla.sa/DotcN83mIYoUkupjKMdxfJ5iuULWTPToc5xAVRkO.jpeg',
        price: 350,
        title: 'ربع نعيمي'),
    Item(
        image:
            'https://cdn.salla.sa/qQVPQ/kYiTe60SHFEPRKewl9EamdLL9Edab7eYx0pKMEif.jpg',
        price: 100,
        title: 'نعيمي بالكيلو'),
  ];
  final List<Item> itemList3 = [
    Item(
        image:
            'https://cdn.salla.sa/7Uv2ZnbDos0fZoX1fUSQMWKDq7mYxezM8kvh1wqt.jpeg',
        price: 60,
        tag: 'جديد',
        tagColor: Color.fromRGBO(132, 15, 15, 1),
        title: 'برجر لحم عجل'),
    Item(
        image:
            'https://cdn.salla.sa/cLyQ411CF6nz6EgMRyo3Fiirmsm0XIai7UDku11Y.jpeg',
        price: 95,
        title: 'أوصال شوي'),
    Item(
        image:
            'https://cdn.salla.sa/8tbiQBKYSSj9cjQLKgUxecpAVcaLbOXM3i5KICD8.jpeg',
        price: 95,
        title: 'ريش غنم'),
  ];
  final List<Item> itemList2 = [
    Item(
        image:
            'https://cdn.salla.sa/DGWNy/SdmVcN3c2ZXu4nYGqzSlqrUjgIm5SnK0qvTYUSLX.jpg',
        price: 1500,
        discount: 10.0,
        tag: '10%',
        tagColor: Colors.red,
        title: 'حري'),
    Item(
        image:
            'https://cdn.salla.sa/RSFk6NYEtrmMzBER0nACjXMbU3mq5j3LCH2gf4Ek.jpeg',
        price: 420,
        title: 'فخذ حري'),
    Item(
        image:
            'https://cdn.salla.sa/qQVPQ/kYiTe60SHFEPRKewl9EamdLL9Edab7eYx0pKMEif.jpg',
        price: 100,
        title: 'حري بالكيلو'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(
        search: true,
      ),
      body: ScrollConfiguration(
        behavior: Behavior(),
        child: RefreshIndicator(
            onRefresh: () async {},
            child: CustomScrollView(slivers: <Widget>[
              Banners(imgList: [
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRBmHgNwdnmp3C7AJt7ZQevJ1_DV8h1hElLgBT21We2RTcJjKNZDXXiTKaqu1ooTKOvNNI&usqp=CAU',
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTb3_-T4pT9GkfDN1SsHPj27bK3VVXHwigUTPlB_brMjHm5qRoDlRTLvS3wMvv6c4pytI4&usqp=CAU'
              ]),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 20.0, left: 20, bottom: 8, top: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("نعيمي بلدي",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16)),
                          Row(
                            children: [
                              Text('مشاهدة الكل',
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 10)),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 15,
                                color: Theme.of(context).primaryColor,
                              )
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                  child: Column(
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
                        itemCount: itemList.length,
                        itemBuilder: (BuildContext ctxt, int index) {
                          return Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                index == 0 ? 8 : 3.0, 0, 0, 0),
                            child: ItemCard(item: itemList[index]),
                          );
                        }),
                  ),
                ],
              )),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 20.0, left: 20, bottom: 8, top: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("حري",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16)),
                          Row(
                            children: [
                              Text('مشاهدة الكل',
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 10)),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 15,
                                color: Theme.of(context).primaryColor,
                              )
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                  child: Column(
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
                        itemCount: itemList2.length,
                        itemBuilder: (BuildContext ctxt, int index) {
                          return Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                index == 0 ? 8 : 3.0, 0, 0, 0),
                            child: ItemCard(item: itemList2[index]),
                          );
                        }),
                  ),
                ],
              )),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 20.0, left: 10, bottom: 8, top: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("اصناف فاخرة",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16)),
                          Row(
                            children: [
                              Text('مشاهدة الكل',
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 10)),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 15,
                                color: Theme.of(context).primaryColor,
                              )
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: SizeConfig.screenWidth,
                    height: 230,
                    child: ListView.builder(
                        padding: EdgeInsets.all(0),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        physics: ScrollPhysics(),
                        itemCount: itemList3.length,
                        itemBuilder: (BuildContext ctxt, int index) {
                          return Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                index == 0 ? 8 : 3.0, 0, 0, 0),
                            child: ItemCard(item: itemList3[index]),
                          );
                        }),
                  ),
                ],
              )),
            ])),
      ),
    );
  }
}
