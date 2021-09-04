import 'package:flutter/material.dart';
import 'package:new_turki/widgets/orders/order_card.dart';
import 'package:new_turki/widgets/primary_app_bar.dart';

class Orders extends StatefulWidget {
  final bool back;

  const Orders({this.back = false});
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  bool selected = false;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(
        title: 'طلباتي',
        back: widget.back,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: ListView(
          padding: EdgeInsets.only(top: 5),
          children: [
            // Padding(
            //   padding: const EdgeInsets.all(15.0),
            //   child: Text('طلباتي',
            //       style: TextStyle(
            //           color: Color.fromRGBO(132, 15, 15, 1),
            //           fontSize: 20,
            //           fontWeight: FontWeight.w700)),
            // ),

            OrderCard(
              image:
                  'https://cdn.salla.sa/DGWNy/SdmVcN3c2ZXu4nYGqzSlqrUjgIm5SnK0qvTYUSLX.jpg',
              total: 1450,
              date: '30/8/2021',
              type: 'توصيل',
              payment: 'تم السداد',
              status: 'جاري التجهيز',
              id: '50805',
              style: TextStyle(
                  height: 1.6,
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                  color: Theme.of(context).primaryColor),
            ),
            OrderCard(
              type: 'استلام من الفرع',
              image:
                  'https://cdn.salla.sa/cLyQ411CF6nz6EgMRyo3Fiirmsm0XIai7UDku11Y.jpeg',
              total: 230,
              date: '22/8/2021',
              payment: 'جاري التحقق من عملية الدفع',
              status: 'تم التوصيل',
              id: '50812',
              style: TextStyle(
                  height: 1.6,
                  fontWeight: FontWeight.normal,
                  fontSize: 10,
                  color: Colors.green),
            ),
            OrderCard(
              type: 'توصيل',
              image:
                  'https://cdn.salla.sa/DotcN83mIYoUkupjKMdxfJ5iuULWTPToc5xAVRkO.jpeg',
              total: 1320,
              payment: 'الدفع عند الاستلام',
              date: '21/8/2021',
              style: TextStyle(
                  height: 1.6,
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                  color: Colors.red),
              status: 'تم الالغاء',
              id: '50833',
            ),
            OrderCard(
              type: 'توصيل',
              image:
                  'https://cdn.salla.sa/DGWNy/SdmVcN3c2ZXu4nYGqzSlqrUjgIm5SnK0qvTYUSLX.jpg',
              total: 1450,
              date: '30/8/2021',
              payment: 'تم السداد',
              status: 'تم التوصيل',
              id: '50812',
              style: TextStyle(
                  height: 1.6,
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                  color: Colors.green),
            ),
            OrderCard(
              type: 'توصيل',
              payment: 'تم السداد',
              image:
                  'https://cdn.salla.sa/cLyQ411CF6nz6EgMRyo3Fiirmsm0XIai7UDku11Y.jpeg',
              total: 230,
              date: '22/8/2021',
              status: 'تم التوصيل',
              id: '50812',
              style: TextStyle(
                  height: 1.6,
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                  color: Colors.green),
            ),
            OrderCard(
              type: 'توصيل',
              payment: 'تم السداد',
              image:
                  'https://cdn.salla.sa/DotcN83mIYoUkupjKMdxfJ5iuULWTPToc5xAVRkO.jpeg',
              total: 1320,
              date: '21/8/2021',
              style: TextStyle(
                  height: 1.6,
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                  color: Colors.red),
              status: 'تم الالغاء',
              id: '50833',
            ),
          ],
        ),
      ),
    );
  }
}
