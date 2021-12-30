import 'package:flutter/material.dart';
import 'package:new_turki/models/products.dart';
import 'package:new_turki/provider/home_provider.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:new_turki/widgets/home/food_appbar.dart';
import 'package:new_turki/widgets/home/product_card.dart';
import 'package:new_turki/widgets/shared/retry.dart';
import 'package:new_turki/widgets/shared/spinkit_indicator.dart';
import 'package:provider/provider.dart';

class ProductsHome3 extends StatefulWidget {
  @override
  _ProductsHome3State createState() => _ProductsHome3State();
}

class _ProductsHome3State extends State<ProductsHome3> {
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController = ScrollController()..addListener(() => setState(() {}));
    final _homeProvider = Provider.of<HomeProvider>(context, listen: false);
    _homeProvider.getFoodsPageData();
    super.initState();
  }

  //used to change appbar icons and title color when user scroll down
  bool get _changeColor {
    return _scrollController.hasClients &&
        _scrollController.offset > (200 - kToolbarHeight);
  }

  final List<ProductData> itemList = [
    ProductData(
      id: 1,
      nameAr: 'خس امريكي',
      nameEn: 'برجر لحم عجل',
      description: 'برجر لحم عجل',
      weight: 'برجر لحم عجل',
      calories: 'برجر لحم عجل',
      noRating: 0,
      image:
          'https://cdn.salla.sa/GJWFPm7k1jcYrBeGI6KBDSB7CxZWjjotXwlPwraL.jpeg',
      price: 8.0,
      isActive: true,
      isShalwata: true,
      isDelivered: 0,
      isPickedUp: 0,
      categoryId: 0,
      subCategoryId: 0,
    ),
    ProductData(
      id: 1,
      nameAr: 'نعناع (حزمة)',
      nameEn: 'برجر لحم عجل',
      description: 'برجر لحم عجل',
      weight: 'برجر لحم عجل',
      calories: 'برجر لحم عجل',
      noRating: 0,
      image:
          'https://cdn.salla.sa/Kbnzd/yYj0EdrYEGChNhNzhz9aXO91Pej2bWCRxCoBjOfE.jpg',
      price: 0.95,
      isActive: true,
      isShalwata: true,
      isDelivered: 0,
      isPickedUp: 0,
      categoryId: 0,
      subCategoryId: 0,
    ),
    ProductData(
      id: 1,
      nameAr: 'خس (حزمة)',
      nameEn: 'برجر لحم عجل',
      description: 'برجر لحم عجل',
      weight: 'برجر لحم عجل',
      calories: 'برجر لحم عجل',
      noRating: 0,
      image:
          'https://cdn.salla.sa/lp3jvaVAOsSWFQ7T5V4n048yNeQiplzD18xXjSBg.jpeg',
      price: 2.50,
      isActive: true,
      isShalwata: true,
      isDelivered: 0,
      isPickedUp: 0,
      categoryId: 0,
      subCategoryId: 0,
    ),
  ];
  final List<ProductData> itemList3 = [
    ProductData(
      id: 1,
      nameAr: 'تفاح احمر',
      nameEn: 'برجر لحم عجل',
      description: 'برجر لحم عجل',
      weight: 'برجر لحم عجل',
      calories: 'برجر لحم عجل',
      noRating: 0,
      image:
          "https://cdn.salla.sa/8mnmyK7AwLjBvqSISfWeCr6zY2rz8kEE8ZpKXYID.jpeg",
      price: 10.0,
      isActive: true,
      isShalwata: true,
      isDelivered: 0,
      isPickedUp: 0,
      categoryId: 0,
      subCategoryId: 0,
    ),
    ProductData(
      id: 1,
      nameAr: 'رمان',
      nameEn: 'برجر لحم عجل',
      description: 'برجر لحم عجل',
      weight: 'برجر لحم عجل',
      calories: 'برجر لحم عجل',
      noRating: 0,
      image:
          'https://cdn.salla.sa/vpYSATTjGbvmBnU0EZ0C98opmxOx3lZay3GvfBkV.jpeg',
      price: 5.0,
      isActive: true,
      isShalwata: true,
      isDelivered: 0,
      isPickedUp: 0,
      categoryId: 0,
      subCategoryId: 0,
    ),
    ProductData(
      id: 1,
      nameAr: 'توت أحمر ',
      nameEn: 'برجر لحم عجل',
      description: 'برجر لحم عجل',
      weight: 'برجر لحم عجل',
      calories: 'برجر لحم عجل',
      noRating: 0,
      image:
          'https://cdn.salla.sa/hxiz4d0M2KYAWxpixIzinzj1bhFYlr6wzgr4XstB.jpeg',
      price: 25.0,
      isActive: true,
      isShalwata: true,
      isDelivered: 0,
      isPickedUp: 0,
      categoryId: 0,
      subCategoryId: 0,
    )
  ];
  final List<ProductData> itemList2 = [
    ProductData(
      id: 1,
      nameAr: 'طماطم',
      nameEn: 'برجر لحم عجل',
      description: 'برجر لحم عجل',
      weight: 'برجر لحم عجل',
      calories: 'برجر لحم عجل',
      noRating: 0,
      image:
          'https://cdn.salla.sa/6oZOhdrnSDGImB1U7dnJzTNR67DAJHytkLVZppbz.jpeg',
      price: 3.0,
      isActive: true,
      isShalwata: true,
      isDelivered: 0,
      isPickedUp: 0,
      categoryId: 0,
      subCategoryId: 0,
    ),
    ProductData(
      id: 1,
      nameAr: 'خيار',
      nameEn: 'برجر لحم عجل',
      description: 'برجر لحم عجل',
      weight: 'برجر لحم عجل',
      calories: 'برجر لحم عجل',
      noRating: 0,
      image:
          'https://cdn.salla.sa/68P1aoUWNag9ThCL9tQdROzfVysFpIlejNpbcovX.jpeg',
      price: 10.0,
      isActive: true,
      isShalwata: true,
      isDelivered: 0,
      isPickedUp: 0,
      categoryId: 0,
      subCategoryId: 0,
    ),
    ProductData(
      id: 1,
      nameAr: 'فلفل حار',
      nameEn: 'برجر لحم عجل',
      description: 'برجر لحم عجل',
      weight: 'برجر لحم عجل',
      calories: 'برجر لحم عجل',
      noRating: 0,
      image:
          'https://cdn.salla.sa/hdQDZKzvzeMyFha6C7e0ZU1ZezgM10NHrYSArpZR.jpeg',
      price: 10.0,
      isActive: true,
      isShalwata: true,
      isDelivered: 0,
      isPickedUp: 0,
      categoryId: 0,
      subCategoryId: 0,
    )
  ];
  @override
  Widget build(BuildContext context) {
    final _homeProvider = Provider.of<HomeProvider>(context);
    return Scaffold(
      body: _homeProvider.foodsIsLoading
          ? SpinkitIndicator()
          : _homeProvider.foodsRetry
              ? Retry(
                  onPressed: () {
                    _homeProvider.getFoodsPageData();
                  },
                )
              : RefreshIndicator(
                  color: Theme.of(context).primaryColor,
                  onRefresh: () async {},
                  child:
                      CustomScrollView(controller: _scrollController, slivers: <
                          Widget>[
                    FoodAppBar(
                      changeColor: _changeColor,
                      banners: [
                        "https://www.khaberni.com/uploads/news_model/2019/07/main_image5d363c0c71c27.jpg",
                        "https://www.uaewomen.net/wp-content/uploads/2019/04/%D8%A7%D9%83%D8%AA%D8%B4%D9%81%D9%8A-%D8%A3%D9%81%D8%B6%D9%84-%D8%A7%D9%84%D8%AE%D8%B6%D8%A7%D8%B1-%D9%88%D8%A7%D9%84%D9%81%D9%88%D8%A7%D9%83%D9%87-%D9%84%D8%AA%D8%B7%D9%88%D9%8A%D9%84-%D8%A7%D9%84%D8%B4%D8%B9%D8%B1.png",
                        "https://popsciarabia.com/wp-content/uploads/2021/06/%D8%AE%D8%B6%D8%B1%D9%88%D8%A7%D8%AA-%D9%81%D9%88%D8%A7%D9%83%D9%87.jpg",
                        "https://babonej.awicdn.com/site-images/sites/default/files/babonej-prod/article/c/5/398369/db5d172415f77a46f738828d7e9534122f64d3df-280321151557.jpg?preset=v4.0_770X577&save-png=1&rnd=511320222SA2BA"
                      ],
                    ),
                    // DiscoverSection(
                    //   discoverList: _homeProvider.discoverList,
                    // ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: 20.0, left: 5, bottom: 8, top: 10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("فواكه",
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, "ProductDetails",
                                        arguments: 1);
                                  },
                                  child: Row(
                                    children: [
                                      Text('مشاهدة الكل',
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 10)),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        size: 15,
                                        color: Theme.of(context).primaryColor,
                                      )
                                    ],
                                  ),
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
                              itemCount: itemList3.length,
                              itemBuilder: (BuildContext ctxt, int index) {
                                return Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      index == 0 ? 8 : 3.0, 0, 0, 0),
                                  child: ProductCard(product: itemList3[index]),
                                );
                              }),
                        ),
                      ],
                    )),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: 20.0, left: 5, bottom: 8, top: 10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("خضار",
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, "ProductDetails",
                                        arguments: 1);
                                  },
                                  child: Row(
                                    children: [
                                      Text('مشاهدة الكل',
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 10)),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        size: 15,
                                        color: Theme.of(context).primaryColor,
                                      )
                                    ],
                                  ),
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
                                  child: ProductCard(product: itemList2[index]),
                                );
                              }),
                        ),
                      ],
                    )),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: 20.0, left: 5, bottom: 8, top: 10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("ورقيات",
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, "ProductDetails",
                                        arguments: 1);
                                  },
                                  child: Row(
                                    children: [
                                      Text('مشاهدة الكل',
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 10)),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        size: 15,
                                        color: Theme.of(context).primaryColor,
                                      )
                                    ],
                                  ),
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
                                  child: ProductCard(product: itemList[index]),
                                );
                              }),
                        ),
                      ],
                    )),
                    // HtmlSection(),
                    // ProductsSection(products: _homeProvider.productsList),
                  ])),
    );
  }
}
