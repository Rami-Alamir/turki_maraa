import 'package:flutter/material.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:new_turki/widgets/cart/cart_card.dart';
import 'package:new_turki/widgets/cart/cart_card2.dart';
import 'package:new_turki/widgets/cart/promo_code.dart';
import 'package:new_turki/widgets/primary_app_bar.dart';
import 'package:new_turki/widgets/rounded_rectangle_button.dart';
import 'invoice.dart';

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({Key? key}) : super(key: key);

  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  bool selected = false;
  final TextEditingController _controller = TextEditingController();

  var value = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(
        title: 'سلة التسوق',
        back: false,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: ListView(
          padding: EdgeInsets.only(top: 15),
          children: [
            CartCard(
              image:
                  'https://cdn.salla.sa/SUhBOwA5SymmGRzaVk9u7fLhryzdmyz30kmBPBfx.jpg',
              price: 1450,
              subtitle: 'هرفي وسط - تقطيع أرباع - اطباق مغلغة',
              qty: 1,
              title: 'نعيمي',
            ),
            CartCard(
              image:
                  'https://cdn.salla.sa/BZO1UQmddN80gCDYphVW5aBCCnwUAx2vSaafilUV.jpeg',
              price: 50,
              subtitle: '',
              qty: 1,
              title: 'كبدة عجل طازجة',
            ),
            CartCard(
              image:
                  'https://cdn.salla.sa/URkxvAaSbSWAQyXEGLub9jJk2jwZykt2suJau981.jpeg',
              price: 180,
              subtitle: ' ريب اي',
              title: 'ستيك',
              qty: 2,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'عنوان التوصيل',
                    style: Theme.of(context)
                        .textTheme
                        .headline1!
                        .copyWith(fontSize: 16),
                  ),
                  Text(
                    'الياسمين - طريق الملك عبد العزيز',
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                        fontSize: 14, fontWeight: FontWeight.w300, height: 2),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20, bottom: 15),
              child: Text(
                'طريقة الدفع',
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(fontSize: 16),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      selected = !selected;
                    });
                  },
                  child: Container(
                    width: SizeConfig.screenWidth! * .45,
                    padding: const EdgeInsets.all(3.0),
                    constraints: const BoxConstraints(
                      minHeight: 100,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: selected
                                ? Color.fromRGBO(132, 15, 15, 1)
                                : Colors.grey)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 18.0),
                          child: Image.asset(
                            'assets/images/cod.png',
                            width: 40,
                            height: 40,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'دفع نقدي',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      selected = !selected;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(3.0),
                    width: SizeConfig.screenWidth! * .45,
                    constraints: const BoxConstraints(
                      minHeight: 100,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: !selected
                                ? Color.fromRGBO(132, 15, 15, 1)
                                : Colors.grey)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Image.asset(
                                'assets/images/applepay.png',
                                width: 40,
                                height: 28,
                              ),
                            ),
                            Image.asset(
                              'assets/images/mada.png',
                              width: 40,
                              height: 28,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Image.asset(
                                'assets/images/visa.png',
                                width: 40,
                                height: 28,
                              ),
                            ),
                            Image.asset(
                              'assets/images/master.png',
                              width: 40,
                              height: 28,
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            'دفع اونلاين',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 28.0, right: 5),
              child: Row(
                children: [
                  Checkbox(
                    value: this.value,
                    checkColor: Colors.white, // color of tick Mark
                    activeColor: Theme.of(context).primaryColor,
                    onChanged: (bool? value) {
                      setState(() {
                        this.value = value!;
                      });
                    },
                  ), //Checkbox
                  Text(
                    'استخدم رصيدي (100.00 ر.س)',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  right: 20, bottom: 10, left: 20, top: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PromoCode(
                    controller: _controller,
                    promoStatus: -1,
                  ),
                ],
              ),
            ),
            Invoice(
              subtotal: 500,
              total: 510,
            ),
            RoundedRectangleButton(
              height: 50,
              padding:
                  EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 20),
              fontSize: 16,
              title: 'اتمام الطلب',
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
