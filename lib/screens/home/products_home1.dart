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

class ProductsHome1 extends StatefulWidget {
  @override
  _ProductsHome1State createState() => _ProductsHome1State();
}

class _ProductsHome1State extends State<ProductsHome1> {
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
      nameAr: 'برجر لحم عجل',
      nameEn: 'برجر لحم عجل',
      description: 'برجر لحم عجل',
      weight: 'برجر لحم عجل',
      calories: 'برجر لحم عجل',
      noRating: 0,
      image:
          'https://cdn.salla.sa/7Uv2ZnbDos0fZoX1fUSQMWKDq7mYxezM8kvh1wqt.jpeg',
      price: 60.0,
      isActive: true,
      isShalwata: true,
      isDelivered: 0,
      isPickedUp: 0,
      categoryId: 0,
      subCategoryId: 0,
    ),
    ProductData(
      id: 1,
      nameAr: 'أوصال شوي',
      nameEn: 'برجر لحم عجل',
      description: 'برجر لحم عجل',
      weight: 'برجر لحم عجل',
      calories: 'برجر لحم عجل',
      noRating: 0,
      image:
          'https://cdn.salla.sa/cLyQ411CF6nz6EgMRyo3Fiirmsm0XIai7UDku11Y.jpeg',
      price: 60.0,
      isActive: true,
      isShalwata: true,
      isDelivered: 0,
      isPickedUp: 0,
      categoryId: 0,
      subCategoryId: 0,
    ),
    ProductData(
      id: 1,
      nameAr: 'ريش غنم',
      nameEn: 'برجر لحم عجل',
      description: 'برجر لحم عجل',
      weight: 'برجر لحم عجل',
      calories: 'برجر لحم عجل',
      noRating: 0,
      image:
          'https://cdn.salla.sa/8tbiQBKYSSj9cjQLKgUxecpAVcaLbOXM3i5KICD8.jpeg',
      price: 95.0,
      isActive: true,
      isShalwata: true,
      isDelivered: 0,
      isPickedUp: 0,
      categoryId: 0,
      subCategoryId: 0,
    )
  ];
  final List<ProductData> itemList3 = [
    ProductData(
      id: 1,
      nameAr: 'نعيمي',
      nameEn: 'برجر لحم عجل',
      description: 'برجر لحم عجل',
      weight: 'برجر لحم عجل',
      calories: 'برجر لحم عجل',
      noRating: 0,
      image:
          'https://cdn.salla.sa/dbPPv/ArNOJzNYSAzorMhVAEw2CVWu8Zid2tdadfIDhfr9.jpg',
      price: 1250.0,
      isActive: true,
      isShalwata: true,
      isDelivered: 0,
      isPickedUp: 0,
      categoryId: 0,
      subCategoryId: 0,
    ),
    ProductData(
      id: 1,
      nameAr: 'ربع نعيمي',
      nameEn: 'برجر لحم عجل',
      description: 'برجر لحم عجل',
      weight: 'برجر لحم عجل',
      calories: 'برجر لحم عجل',
      noRating: 0,
      image:
          'https://cdn.salla.sa/DotcN83mIYoUkupjKMdxfJ5iuULWTPToc5xAVRkO.jpeg',
      price: 600.0,
      isActive: true,
      isShalwata: true,
      isDelivered: 0,
      isPickedUp: 0,
      categoryId: 0,
      subCategoryId: 0,
    ),
    ProductData(
      id: 1,
      nameAr: 'نعيمي بالكيلو',
      nameEn: 'برجر لحم عجل',
      description: 'برجر لحم عجل',
      weight: 'برجر لحم عجل',
      calories: 'برجر لحم عجل',
      noRating: 0,
      image:
          'https://cdn.salla.sa/qQVPQ/kYiTe60SHFEPRKewl9EamdLL9Edab7eYx0pKMEif.jpg',
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
      nameAr: 'حري',
      nameEn: 'برجر لحم عجل',
      description: 'برجر لحم عجل',
      weight: 'برجر لحم عجل',
      calories: 'برجر لحم عجل',
      noRating: 0,
      image:
          'https://cdn.salla.sa/DGWNy/SdmVcN3c2ZXu4nYGqzSlqrUjgIm5SnK0qvTYUSLX.jpg',
      price: 1500.0,
      isActive: true,
      isShalwata: true,
      isDelivered: 0,
      isPickedUp: 0,
      categoryId: 0,
      subCategoryId: 0,
    ),
    ProductData(
      id: 1,
      nameAr: 'فخذ حري',
      nameEn: 'برجر لحم عجل',
      description: 'برجر لحم عجل',
      weight: 'برجر لحم عجل',
      calories: 'برجر لحم عجل',
      noRating: 0,
      image:
          'https://cdn.salla.sa/RSFk6NYEtrmMzBER0nACjXMbU3mq5j3LCH2gf4Ek.jpeg',
      price: 420.0,
      isActive: true,
      isShalwata: true,
      isDelivered: 0,
      isPickedUp: 0,
      categoryId: 0,
      subCategoryId: 0,
    ),
    ProductData(
      id: 1,
      nameAr: 'حري بالكيلو',
      nameEn: 'برجر لحم عجل',
      description: 'برجر لحم عجل',
      weight: 'برجر لحم عجل',
      calories: 'برجر لحم عجل',
      noRating: 0,
      image:
          'https://cdn.salla.sa/8tbiQBKYSSj9cjQLKgUxecpAVcaLbOXM3i5KICD8.jpeg',
      price: 100.0,
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
                      banners: _homeProvider.bannersList,
                    ),
                    DiscoverSection(
                      discoverList: _homeProvider.discoverList,
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: 20.0, left: 5, bottom: 8, top: 10),
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
                                Text("حري",
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
                                Text("أصناف فاخرة",
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
