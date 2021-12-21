// import 'package:flutter/material.dart';
// import 'package:new_turki/models/item.dart';
// import 'package:new_turki/utilities/size_config.dart';
// import 'package:new_turki/widgets/item_card2.dart';
// import 'package:new_turki/widgets/primary_app_bar.dart';
//
// class HomeList2 extends StatefulWidget {
//   final Item item;
//
//   const HomeList2({required this.item});
//
//   @override
//   _HomeList2State createState() => _HomeList2State();
// }
//
// class _HomeList2State extends State<HomeList2> {
//   final List<Item> itemList = [
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
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PrimaryAppBar(
//         title: widget.item.title,
//         back: true,
//       ),
//       body: ListView(
//         children: [
//           Stack(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: Container(
//                   color: Colors.transparent,
//                   height: 250,
//                   width: SizeConfig.screenWidth!,
//                   child: Card(
//                     elevation: 1,
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15.0)),
//                     child: Container(
//                       color: Theme.of(context).accentColor,
//                       width: 160,
//                       height: 160,
//                       child: ClipRRect(
//                           borderRadius: BorderRadius.circular(15.0),
//                           child: Image.network(
//                             '${widget.item.image?.trim()}',
//                             width: 160,
//                             height: 160,
//                             fit: BoxFit.cover,
//                           )),
//                     ),
//                   ),
//                 ),
//               ),
//               Positioned(
//                   top: 40,
//                   right: 40,
//                   child: Container(
//                     width: 180,
//                     child: Text(
//                       'تشكيلة من المنتجات الفاخرة سريعة التحضير',
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                           height: 2),
//                     ),
//                   ))
//             ],
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 15.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 ItemCard2(
//                   item: itemList[0],
//                 ),
//                 ItemCard2(
//                   item: itemList[1],
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 10.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 ItemCard2(
//                   item: itemList[2],
//                 ),
//                 ItemCard2(
//                   item: itemList[0],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
