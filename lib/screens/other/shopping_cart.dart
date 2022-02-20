// import 'package:flutter/material.dart';
// import 'package:new_turki/utilities/size_config.dart';
// import 'package:new_turki/widgets/cart/cart_card.dart';
// import 'package:new_turki/widgets/cart/note.dart';
// import 'package:new_turki/widgets/cart/promo_code.dart';
// import 'package:new_turki/widgets/primary_app_bar.dart';
// import 'package:new_turki/widgets/rounded_rectangle_button.dart';
// import 'invoice.dart';
//
// class ShoppingCart extends StatefulWidget {
//   const ShoppingCart({Key? key}) : super(key: key);
//
//   @override
//   _ShoppingCartState createState() => _ShoppingCartState();
// }
//
// class _ShoppingCartState extends State<ShoppingCart> {
//   bool selected = false;
//   final TextEditingController _controller = TextEditingController();
//   final TextEditingController _controller2 = TextEditingController();
//
//   var value = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PrimaryAppBar(
//         title: 'سلة التسوق',
//         back: false,
//       ),
//       body: GestureDetector(
//         onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
//         child: ListView(
//           padding: EdgeInsets.only(top: 15),
//           children: [
//             CartCard(
//               image:
//                   'https://cdn.salla.sa/SUhBOwA5SymmGRzaVk9u7fLhryzdmyz30kmBPBfx.jpg',
//               price: 1450,
//               subtitle: 'هرفي وسط - تقطيع أرباع - اطباق مغلغة',
//               qty: 1,
//               title: 'نعيمي',
//             ),
//             CartCard(
//               image:
//                   'https://cdn.salla.sa/BZO1UQmddN80gCDYphVW5aBCCnwUAx2vSaafilUV.jpeg',
//               price: 50,
//               subtitle: '',
//               qty: 1,
//               title: 'كبدة عجل طازجة',
//             ),
//             CartCard(
//               image:
//                   'https://cdn.salla.sa/URkxvAaSbSWAQyXEGLub9jJk2jwZykt2suJau981.jpeg',
//               price: 180,
//               subtitle: ' ريب اي',
//               title: 'ستيك',
//               qty: 2,
//             ),
//             Padding(
//               padding: const EdgeInsets.all(20),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'عنوان التوصيل',
//                     style: Theme.of(context)
//                         .textTheme
//                         .headline1!
//                         .copyWith(fontSize: 16),
//                   ),
//                   Text(
//                     'الياسمين - طريق الملك عبد العزيز',
//                     style: Theme.of(context).textTheme.headline1!.copyWith(
//                         fontSize: 14, fontWeight: FontWeight.w300, height: 2),
//                   ),
//                 ],
//               ),
//             ),
//
//             Padding(
//               padding: const EdgeInsets.only(
//                   right: 20, bottom: 10, left: 20, top: 20),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Note(
//                     controller: _controller2,
//                     promoStatus: -1,
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(
//                   right: 20, bottom: 10, left: 20, top: 20),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   PromoCode(
//                     controller: _controller,
//                     promoStatus: -1,
//                   ),
//                 ],
//               ),
//             ),
//             Invoice(
//               subtotal: 500,
//               total: 510,
//             ),
//             RoundedRectangleButton(
//               height: 50,
//               padding:
//                   EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 20),
//               fontSize: 16,
//               title: 'اتمام الطلب',
//               onPressed: () {},
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
