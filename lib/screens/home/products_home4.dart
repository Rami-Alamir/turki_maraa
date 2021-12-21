import 'package:flutter/material.dart';
import 'package:new_turki/models/item.dart';
import 'package:new_turki/models/products.dart';
import 'package:new_turki/provider/home_provider.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:new_turki/widgets/home/discover_section.dart';
import 'package:new_turki/widgets/home/food_appbar.dart';
import 'package:new_turki/widgets/home/product_card.dart';
import 'package:new_turki/widgets/home/products_section.dart';
import 'package:new_turki/widgets/shared/retry.dart';
import 'package:new_turki/widgets/shared/spinkit_indicator.dart';
import 'package:provider/provider.dart';

class ProductsHome4 extends StatefulWidget {
  @override
  _ProductsHome4State createState() => _ProductsHome4State();
}

class _ProductsHome4State extends State<ProductsHome4> {
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
      nameAr: 'بوكس الشواء',
      nameEn: 'برجر لحم عجل',
      description: 'برجر لحم عجل',
      weight: 'برجر لحم عجل',
      calories: 'برجر لحم عجل',
      noRating: 0,
      image:
          'https://api.fishday.com.sa/storage/uploads/qaWFnSKsLQUPcnBiZyUndDIeu5BY3MODk4n145Gq.webp',
      price: 334.0,
      isActive: true,
      isShalwata: true,
      isDelivered: 0,
      isPickedUp: 0,
      categoryId: 0,
      subCategoryId: 0,
    ),
    ProductData(
      id: 1,
      nameAr: 'بوكس العائلة',
      nameEn: 'برجر لحم عجل',
      description: 'برجر لحم عجل',
      weight: 'برجر لحم عجل',
      calories: 'برجر لحم عجل',
      noRating: 0,
      image:
          'https://api.fishday.com.sa/storage/uploads/3cP8auukALByiVRQZX2EAHOVmwajqu4JkxBngqBu.webp',
      price: 125.0,
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
      nameAr: 'الشعور',
      nameEn: 'برجر لحم عجل',
      description: 'برجر لحم عجل',
      weight: 'برجر لحم عجل',
      calories: 'برجر لحم عجل',
      noRating: 0,
      image:
          'https://api.fishday.com.sa/storage/uploads/6YxtN3a86ULmYBMnKzUcFAAU28lbp1zuWsmtOjdk.webp',
      price: 63.0,
      isActive: true,
      isShalwata: true,
      isDelivered: 0,
      isPickedUp: 0,
      categoryId: 0,
      subCategoryId: 0,
    ),
    ProductData(
      id: 1,
      nameAr: 'القاروص',
      nameEn: 'برجر لحم عجل',
      description: 'برجر لحم عجل',
      weight: 'برجر لحم عجل',
      calories: 'برجر لحم عجل',
      noRating: 0,
      image:
          'https://api.fishday.com.sa/storage/uploads/l3nJodyibBuWvRxHiydShAsW6r5JoeK9rcv7SapF.webp',
      price: 35.0,
      isActive: true,
      isShalwata: true,
      isDelivered: 0,
      isPickedUp: 0,
      categoryId: 0,
      subCategoryId: 0,
    ),
    ProductData(
      id: 1,
      nameAr: 'الهامور',
      nameEn: 'برجر لحم عجل',
      description: 'برجر لحم عجل',
      weight: 'برجر لحم عجل',
      calories: 'برجر لحم عجل',
      noRating: 0,
      image:
          'https://api.fishday.com.sa/storage/uploads/vbR7bnUmEKYRwMTaC5T6yyNVjU1eiIkdqWrohjlt.webp',
      price: 100.0,
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
      nameAr: 'الروبيان المستزرع',
      nameEn: 'برجر لحم عجل',
      description: 'برجر لحم عجل',
      weight: 'برجر لحم عجل',
      calories: 'برجر لحم عجل',
      noRating: 0,
      image:
          'https://api.fishday.com.sa/storage/uploads/0Hi44wp7pVdCKdKIijyLVdfmyzcyHpngRsZun6AF.webp',
      price: 66.0,
      isActive: true,
      isShalwata: true,
      isDelivered: 0,
      isPickedUp: 0,
      categoryId: 0,
      subCategoryId: 0,
    ),
    ProductData(
      id: 1,
      nameAr: 'الروبيان البحري',
      nameEn: 'برجر لحم عجل',
      description: 'برجر لحم عجل',
      weight: 'برجر لحم عجل',
      calories: 'برجر لحم عجل',
      noRating: 0,
      image:
          'https://api.fishday.com.sa/storage/uploads/ulKfuRaWLbaxd7mjW4nctebh5Fi2a4lykkurX3gA.webp',
      price: 110.0,
      isActive: true,
      isShalwata: true,
      isDelivered: 0,
      isPickedUp: 0,
      categoryId: 0,
      subCategoryId: 0,
    ),
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
                        "https://i0.wp.com/baytdz.com/wp-content/uploads/2020/03/d8a7d981d8b6d984-d8a7d986d988d8a7d8b9-d8a7d984d8b3d985d983-d981d8a7d8a6d8afd8a9_5e67a15cc7350.jpeg?w=650&ssl=1",
                        "https://image.freepik.com/free-psd/seafood-restaurant-banner_23-2148636160.jpg"
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
                                Text("اسماك",
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
                                Text("الروبيان",
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
                                Text("البوكسات",
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
