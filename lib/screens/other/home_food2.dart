// import 'package:flutter/material.dart';
// import 'package:new_turki/models/item.dart';
// import 'package:new_turki/screens/home/home_list.dart';
// import 'package:new_turki/utilities/behavior.dart';
// import 'package:new_turki/utilities/r_a7_i_c_o_n_s_icons.dart';
// import 'package:new_turki/utilities/size_config.dart';
// import 'package:new_turki/widgets/banners2.dart';
// import 'package:new_turki/widgets/discover_card.dart';
// import 'package:new_turki/widgets/product_card.dart';
// import 'package:new_turki/widgets/logo.dart';
// import 'home/search.dart';
//
// class HomeFood2 extends StatefulWidget {
//   const HomeFood2({Key? key}) : super(key: key);
//
//   @override
//   _HomeFood2State createState() => _HomeFood2State();
// }
//
// class _HomeFood2State extends State<HomeFood2> {
//   final List<Item> itemList = [
//     Item(
//         image:
//             'https://cdn.salla.sa/dbPPv/ArNOJzNYSAzorMhVAEw2CVWu8Zid2tdadfIDhfr9.jpg',
//         price: 1850,
//         title: 'نعيمي'),
//     Item(
//         image:
//             'https://cdn.salla.sa/DotcN83mIYoUkupjKMdxfJ5iuULWTPToc5xAVRkO.jpeg',
//         price: 350,
//         title: 'ربع نعيمي'),
//     Item(
//         image:
//             'https://cdn.salla.sa/qQVPQ/kYiTe60SHFEPRKewl9EamdLL9Edab7eYx0pKMEif.jpg',
//         price: 100,
//         title: 'نعيمي بالكيلو'),
//   ];
//   final List<Item> itemList7 = [
//     Item(
//         image:
//             'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQZgsBZ51rLjHnX3JCGUxMRPZ8jy--uJp9C3RIfonWo05IwLKYw37772Q1VMI6nrdWCk1E&usqp=CAU',
//         price: 1850,
//         title: 'عروضنا'),
//     Item(
//         image:
//             'https://media.istockphoto.com/photos/ribeye-steaks-cooking-on-flaming-grill-panorama-picture-id1151530639?k=6&m=1151530639&s=612x612&w=0&h=N7SM5rN4F6gkTeOU2yiObOHo8Zjl7zalvdQ6SkQLOp4=',
//         price: 100,
//         title: 'باربكيو'),
//     Item(
//         image:
//             'https://expertphotography.b-cdn.net/wp-content/uploads/2020/06/meat-photography-12.jpg',
//         price: 100,
//         title: 'سلملي عالجوع'),
//     Item(
//         image:
//             'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQsUMKOybQvnZpcVZNoLQ9gR5c94P5K7qDsE1UJ6tudSHnWDilW27S2kliLFe4CxzcTcS0&usqp=CAU',
//         price: 350,
//         title: 'جديدنا'),
//   ];
//   final List<Item> itemList3 = [
//     Item(
//         image:
//             'https://cdn.salla.sa/7Uv2ZnbDos0fZoX1fUSQMWKDq7mYxezM8kvh1wqt.jpeg',
//         price: 60,
//         tag: 'جديد',
//         tagColor: Color.fromRGBO(132, 15, 15, 1),
//         title: 'برجر لحم عجل'),
//     Item(
//         image:
//             'https://cdn.salla.sa/cLyQ411CF6nz6EgMRyo3Fiirmsm0XIai7UDku11Y.jpeg',
//         price: 95,
//         title: 'أوصال شوي'),
//     Item(
//         image:
//             'https://cdn.salla.sa/8tbiQBKYSSj9cjQLKgUxecpAVcaLbOXM3i5KICD8.jpeg',
//         price: 95,
//         title: 'ريش غنم'),
//   ];
//   final List<Item> itemList2 = [
//     Item(
//         image:
//             'https://cdn.salla.sa/DGWNy/SdmVcN3c2ZXu4nYGqzSlqrUjgIm5SnK0qvTYUSLX.jpg',
//         price: 1500,
//         discount: 10.0,
//         tag: '10%',
//         tagColor: Colors.red,
//         title: 'حري'),
//     Item(
//         image:
//             'https://cdn.salla.sa/RSFk6NYEtrmMzBER0nACjXMbU3mq5j3LCH2gf4Ek.jpeg',
//         price: 420,
//         title: 'فخذ حري'),
//     Item(
//         image:
//             'https://cdn.salla.sa/qQVPQ/kYiTe60SHFEPRKewl9EamdLL9Edab7eYx0pKMEif.jpg',
//         price: 100,
//         title: 'حري بالكيلو'),
//   ];
//   ScrollController _scrollController = ScrollController();
//   @override
//   void initState() {
//     super.initState();
//
//     _scrollController = ScrollController()
//       ..addListener(() => setState(() {
//             print(
//                 'Scroll view Listener is called offset ${_scrollController.offset}');
//           }));
//   }
//
//   bool get _changecolor {
//     return _scrollController.hasClients &&
//         _scrollController.offset > (200 - kToolbarHeight);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ScrollConfiguration(
//         behavior: Behavior(),
//         child: RefreshIndicator(
//             color: Theme.of(context).primaryColor,
//             onRefresh: () async {},
//             child: CustomScrollView(controller: _scrollController, slivers: <
//                 Widget>[
//               SliverAppBar(
//                   title: Logo(
//                     type: _changecolor ? 2 : 1,
//                   ),
//                   leading: IconButton(
//                     icon: Icon(
//                       Icons.arrow_back_ios,
//                       color: _changecolor
//                           ? Theme.of(context).primaryColor
//                           : Theme.of(context).backgroundColor ==
//                                   Color.fromRGBO(243, 224, 177, 1)
//                               ? Color.fromRGBO(243, 224, 177, 1)
//                               : Colors.white,
//                     ),
//                     onPressed: () => Navigator.pop(context),
//                   ),
//                   backgroundColor: Theme.of(context).backgroundColor,
//                   // backgroundColor: Colors.transparent,
//                   pinned: true,
//                   actionsIconTheme: IconThemeData(
//                     color: _changecolor
//                         ? Theme.of(context).primaryColor
//                         : Theme.of(context).backgroundColor ==
//                                 Color.fromRGBO(243, 224, 177, 1)
//                             ? Color.fromRGBO(243, 224, 177, 1)
//                             : Colors.white,
//                   ),
//                   actions: [
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: IconButton(
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(builder: (context) => Search()),
//                           );
//                         },
//                         icon: Icon(
//                           RA7ICONS.search,
//                           size: 25,
//                         ),
//                       ),
//                     )
//                   ],
//                   elevation: 0.3,
//                   expandedHeight: 230.0,
//                   flexibleSpace: FlexibleSpaceBar(
//                     centerTitle: true,
//                     title: Text('',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 16.0,
//                         )),
//                     background: Banners2(imgList: [
//                       'https://www.cooperbutchers.com/media/mbimages/b/a/banner_02.jpg',
//                       'https://media-exp1.licdn.com/dms/image/C4E1BAQG1SWqAyr9jaw/company-background_10000/0/1612628803012?e=2159024400&v=beta&t=sxVAog3nqeO0uV4HwE2JpvoTp57oxNSAWfMGYKokERo',
//                       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRBmHgNwdnmp3C7AJt7ZQevJ1_DV8h1hElLgBT21We2RTcJjKNZDXXiTKaqu1ooTKOvNNI&usqp=CAU',
//                       'https://pbs.twimg.com/media/E9e-hOMWUAEnAw2.jpg'
//                     ]),
//                   )),
//               SliverToBoxAdapter(
//                 child: Padding(
//                   padding: const EdgeInsets.only(
//                       right: 20.0, left: 20, bottom: 8, top: 15),
//                   child: Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text("اكتشف",
//                               style: TextStyle(
//                                   color: Theme.of(context).primaryColor,
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 16)),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SliverToBoxAdapter(
//                   child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     width: SizeConfig.screenWidth,
//                     height: 100,
//                     child: ListView.builder(
//                         padding: EdgeInsets.symmetric(horizontal: 5),
//                         shrinkWrap: true,
//                         scrollDirection: Axis.horizontal,
//                         physics: ScrollPhysics(),
//                         itemCount: itemList7.length,
//                         itemBuilder: (BuildContext ctxt, int index) {
//                           return Padding(
//                             padding: EdgeInsetsDirectional.fromSTEB(
//                                 index == 0 ? 8 : 3.0, 0, 8, 0),
//                             child: DiscoverCard(
//                               item: itemList7[index],
//                             ),
//                           );
//                         }),
//                   ),
//                 ],
//               )),
//               SliverToBoxAdapter(
//                 child: Padding(
//                   padding: const EdgeInsets.only(
//                       right: 20.0, left: 5, bottom: 8, top: 10),
//                   child: Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text("نعيمي بلدي",
//                               style: TextStyle(
//                                   color: Theme.of(context).primaryColor,
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 16)),
//                           InkWell(
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => HomeList()),
//                               );
//                             },
//                             child: Row(
//                               children: [
//                                 Text('مشاهدة الكل',
//                                     style: TextStyle(
//                                         color: Theme.of(context).primaryColor,
//                                         fontWeight: FontWeight.normal,
//                                         fontSize: 10)),
//                                 Icon(
//                                   Icons.arrow_forward_ios,
//                                   size: 15,
//                                   color: Theme.of(context).primaryColor,
//                                 )
//                               ],
//                             ),
//                           )
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SliverToBoxAdapter(
//                   child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     width: SizeConfig.screenWidth,
//                     height: 200,
//                     child: ListView.builder(
//                         padding: EdgeInsets.all(0),
//                         shrinkWrap: true,
//                         scrollDirection: Axis.horizontal,
//                         physics: ScrollPhysics(),
//                         itemCount: itemList.length,
//                         itemBuilder: (BuildContext ctxt, int index) {
//                           return Padding(
//                             padding: EdgeInsetsDirectional.fromSTEB(
//                                 index == 0 ? 8 : 3.0, 0, 0, 0),
//                             child: ItemCard(item: itemList[index]),
//                           );
//                         }),
//                   ),
//                 ],
//               )),
//               SliverToBoxAdapter(
//                 child: Padding(
//                   padding: const EdgeInsets.only(
//                       right: 20.0, left: 5, bottom: 8, top: 10),
//                   child: Column(
//                     children: [
//                       InkWell(
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(builder: (context) => HomeList()),
//                           );
//                         },
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text("حري",
//                                 style: TextStyle(
//                                     color: Theme.of(context).primaryColor,
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 16)),
//                             Row(
//                               children: [
//                                 Text('مشاهدة الكل',
//                                     style: TextStyle(
//                                         color: Theme.of(context).primaryColor,
//                                         fontWeight: FontWeight.normal,
//                                         fontSize: 10)),
//                                 Icon(
//                                   Icons.arrow_forward_ios,
//                                   size: 15,
//                                   color: Theme.of(context).primaryColor,
//                                 )
//                               ],
//                             )
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SliverToBoxAdapter(
//                   child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     width: SizeConfig.screenWidth,
//                     height: 200,
//                     child: ListView.builder(
//                         padding: EdgeInsets.all(0),
//                         shrinkWrap: true,
//                         scrollDirection: Axis.horizontal,
//                         physics: ScrollPhysics(),
//                         itemCount: itemList2.length,
//                         itemBuilder: (BuildContext ctxt, int index) {
//                           return Padding(
//                             padding: EdgeInsetsDirectional.fromSTEB(
//                                 index == 0 ? 8 : 3.0, 0, 0, 0),
//                             child: ItemCard(item: itemList2[index]),
//                           );
//                         }),
//                   ),
//                 ],
//               )),
//               SliverToBoxAdapter(
//                 child: Padding(
//                   padding: const EdgeInsets.only(
//                       right: 20.0, left: 5, bottom: 8, top: 10),
//                   child: Column(
//                     children: [
//                       InkWell(
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(builder: (context) => HomeList()),
//                           );
//                         },
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text("اصناف فاخرة",
//                                 style: TextStyle(
//                                     color: Theme.of(context).primaryColor,
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 16)),
//                             Row(
//                               children: [
//                                 Text('مشاهدة الكل',
//                                     style: TextStyle(
//                                         color: Theme.of(context).primaryColor,
//                                         fontWeight: FontWeight.normal,
//                                         fontSize: 10)),
//                                 Icon(
//                                   Icons.arrow_forward_ios,
//                                   size: 15,
//                                   color: Theme.of(context).primaryColor,
//                                 )
//                               ],
//                             )
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SliverToBoxAdapter(
//                   child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     width: SizeConfig.screenWidth,
//                     height: 230,
//                     child: ListView.builder(
//                         padding: EdgeInsets.all(0),
//                         shrinkWrap: true,
//                         scrollDirection: Axis.horizontal,
//                         physics: ScrollPhysics(),
//                         itemCount: itemList3.length,
//                         itemBuilder: (BuildContext ctxt, int index) {
//                           return Padding(
//                             padding: EdgeInsetsDirectional.fromSTEB(
//                                 index == 0 ? 8 : 3.0, 0, 0, 0),
//                             child: ItemCard(item: itemList3[index]),
//                           );
//                         }),
//                   ),
//                 ],
//               )),
//             ])),
//       ),
//     );
//   }
// }
