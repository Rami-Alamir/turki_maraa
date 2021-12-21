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

class ProductsHome2 extends StatefulWidget {
  @override
  _ProductsHome2State createState() => _ProductsHome2State();
}

class _ProductsHome2State extends State<ProductsHome2> {
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
      nameAr: 'حمام فرنسي',
      nameEn: 'برجر لحم عجل',
      description: 'برجر لحم عجل',
      weight: 'برجر لحم عجل',
      calories: 'برجر لحم عجل',
      noRating: 0,
      image:
          'https://cdnprod.mafretailproxy.com/sys-master-root/hd1/h05/9194857070622/110964_main.jpg_480Wx480H',
      price: 50.0,
      isActive: true,
      isShalwata: true,
      isDelivered: 0,
      isPickedUp: 0,
      categoryId: 0,
      subCategoryId: 0,
    ),
    ProductData(
      id: 1,
      nameAr: 'سمان طازج',
      nameEn: 'برجر لحم عجل',
      description: 'برجر لحم عجل',
      weight: 'برجر لحم عجل',
      calories: 'برجر لحم عجل',
      noRating: 0,
      image:
          'https://cdnprod.mafretailproxy.com/sys-master-root/h6f/h81/9181882318878/110965_main.jpg_480Wx480H',
      price: 30.0,
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
      nameAr: 'دجاج مبرد 1100 جرام',
      nameEn: 'برجر لحم عجل',
      description: 'برجر لحم عجل',
      weight: 'برجر لحم عجل',
      calories: 'برجر لحم عجل',
      noRating: 0,
      image:
          'https://media.zid.store/cdn-cgi/image/w=300,h=300,q=85,f=auto/https://media.zid.store/thumbs/803ad7bc-411b-4317-8728-971bbe2327f6/6c051667-733a-4452-9ed3-e2f1787a839a-thumbnail-370x370-70.jpg',
      price: 16.0,
      isActive: true,
      isShalwata: true,
      isDelivered: 0,
      isPickedUp: 0,
      categoryId: 0,
      subCategoryId: 0,
    ),
    ProductData(
      id: 1,
      nameAr: 'دجاج مبرد 1000 جرام',
      nameEn: 'برجر لحم عجل',
      description: 'برجر لحم عجل',
      weight: 'برجر لحم عجل',
      calories: 'برجر لحم عجل',
      noRating: 0,
      image:
          'https://media.zid.store/cdn-cgi/image/w=300,h=300,q=85,f=auto/https://media.zid.store/thumbs/803ad7bc-411b-4317-8728-971bbe2327f6/6c051667-733a-4452-9ed3-e2f1787a839a-thumbnail-370x370-70.jpg',
      price: 15.0,
      isActive: true,
      isShalwata: true,
      isDelivered: 0,
      isPickedUp: 0,
      categoryId: 0,
      subCategoryId: 0,
    ),
    ProductData(
      id: 1,
      nameAr: 'دجاج مبرد 900 جرام',
      nameEn: 'برجر لحم عجل',
      description: 'برجر لحم عجل',
      weight: 'برجر لحم عجل',
      calories: 'برجر لحم عجل',
      noRating: 0,
      image:
          'https://media.zid.store/cdn-cgi/image/w=300,h=300,q=85,f=auto/https://media.zid.store/thumbs/803ad7bc-411b-4317-8728-971bbe2327f6/6c051667-733a-4452-9ed3-e2f1787a839a-thumbnail-370x370-70.jpg',
      price: 14.0,
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
      nameAr: 'دجاج متبل عربي عادي',
      nameEn: 'برجر لحم عجل',
      description: 'برجر لحم عجل',
      weight: 'برجر لحم عجل',
      calories: 'برجر لحم عجل',
      noRating: 0,
      image:
          'https://media.zid.store/cdn-cgi/image/w=300,h=300,q=85,f=auto/https://media.zid.store/thumbs/803ad7bc-411b-4317-8728-971bbe2327f6/6c051667-733a-4452-9ed3-e2f1787a839a-thumbnail-370x370-70.jpg',
      price: 22.0,
      isActive: true,
      isShalwata: true,
      isDelivered: 0,
      isPickedUp: 0,
      categoryId: 0,
      subCategoryId: 0,
    ),
    ProductData(
      id: 1,
      nameAr: 'دجاج متبل حار',
      nameEn: 'برجر لحم عجل',
      description: 'برجر لحم عجل',
      weight: 'برجر لحم عجل',
      calories: 'برجر لحم عجل',
      noRating: 0,
      image:
          'https://media.zid.store/cdn-cgi/image/w=300,h=300,q=85,f=auto/https://media.zid.store/thumbs/803ad7bc-411b-4317-8728-971bbe2327f6/e8c61b53-24c9-4f74-bb7e-d2694ff4b853-thumbnail-370x370-70.jpg',
      price: 22.0,
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
                        "https://www.addustour.com/file.php?fileid=463596&width=1140&height=450",
                        "https://cdn.shopify.com/s/files/1/0369/1311/9372/collections/raw_chicken_spices.jpg.653x0_q80_crop-smart_1080x.jpg?v=1585437075"
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
                                Text("دجاج كامل",
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
                                Text("دجاج متبل",
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
                                Text("الحمام والسمان",
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
