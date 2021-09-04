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
                  'https://cdn.salla.sa/DGWNy/SdmVcN3c2ZXu4nYGqzSlqrUjgIm5SnK0qvTYUSLX.jpg',
              price: 1450,
              title: 'حري',
              subtitle:
                  'خروف حري وسط من إنتاج مزرعتنا وزنه بعد الذبح لا يقل عن 14 كيلو',
            ),

            FavouriteCard(
              image:
                  'https://cdn.salla.sa/j1teZ7YCaJKLWZu7Qsol4cGva1dz9VMt8jkatYIq.jpeg',
              price: 50,
              title: 'أوصال عجل',
              subtitle: 'أوصال عجل مع دهن خفيف',
            ),
            FavouriteCard(
              image:
                  'https://cdn.salla.sa/3jpV0mrHh4FFTH61SSkavrFYqaLX6euK8wBUR70G.jpeg',
              price: 50,
              title: 'مفروم عجل بدون دهن',
              subtitle:
                  '(لحمة حمراء) يتم إختيارها حسب طلبكم من العجل (البقر) ويتم فرمها وتوزيعها في الأطباق حسب رغبتكم',
            ),
            FavouriteCard(
              image:
                  'https://cdn.salla.sa/HeMRLkpnfrIjtVzTu6twhTXqxgHENAG1SC09mcnQ.jpeg',
              price: 99,
              title: 'ستيك ريب اي',
              subtitle: 'استمتع بشرائح اللحم الطازجة',
            ),
            FavouriteCard(
              image:
                  'https://cdn.salla.sa/j1teZ7YCaJKLWZu7Qsol4cGva1dz9VMt8jkatYIq.jpeg',
              price: 50,
              title: 'أوصال عجل',
              subtitle: 'أوصال عجل مع دهن خفيف',
            ),
          ],
        ),
      ),
    );
  }
}
