import 'package:flutter/material.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:new_turki/widgets/cart/cart_card.dart';
import 'package:new_turki/widgets/cart/promo_code.dart';
import 'package:new_turki/widgets/favourite/favourite_card.dart';
import 'package:new_turki/widgets/primary_app_bar.dart';
import 'package:new_turki/widgets/rounded_rectangle_button.dart';

class Favourite extends StatefulWidget {
  const Favourite({Key? key}) : super(key: key);

  @override
  _FavouriteState createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  bool selected = false;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(title: 'المفضلة', back: true),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: ListView(
          padding: EdgeInsets.only(top: 0),
          children: [
            // Padding(
            //   padding: const EdgeInsets.all(15.0),
            //   child: Text('المفضلة',
            //       style: TextStyle(
            //           color: Color.fromRGBO(132, 15, 15, 1),
            //           fontSize: 20,
            //           fontWeight: FontWeight.w700)),
            // ),
            FavouriteCard(
              image:
                  'https://cdn.salla.sa/SUhBOwA5SymmGRzaVk9u7fLhryzdmyz30kmBPBfx.jpg',
              price: 1450,
              title: 'نعيمي',
            ),
            Divider(
              height: 1,
              color: Colors.grey.withOpacity(0.4),
              endIndent: 10,
              indent: 10,
            ),
            FavouriteCard(
              image:
                  'https://cdn.salla.sa/BZO1UQmddN80gCDYphVW5aBCCnwUAx2vSaafilUV.jpeg',
              price: 50,
              title: 'كبدة عجل طازجة',
            ),
          ],
        ),
      ),
    );
  }
}
