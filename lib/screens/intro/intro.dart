import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:new_turki/models/intro_data.dart';
import 'package:new_turki/screens/app/app.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:new_turki/widgets/shared/dots_indicator.dart';

class Intro extends StatefulWidget {
  @override
  _IntroState createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  int mSelectedPosition = 0;

  final List<IntroData> list = [
    IntroData('assets/images/q1.png', 'اختر منتجك المفضل',
        "بعدها فريقنا المحترف بيساعدك وياكدلك الطلب"),
    IntroData('assets/images/q2.png', 'فريقنا بيقوم بتحضير طلبك',
        "يتم التحضير بعناية باشراف من فريق الجودة والفريق الطبي"),
    IntroData('assets/images/q5.png', 'اختر طريقة الدفع المناسبة',
        'نوفر لك العديد من طرق الدفع'),
    IntroData('assets/images/q6.png', 'حدد عنوان التوصيل',
        "فريقنا بيقوم بتوصيلها لك في الموعد المحدد"),
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final double _width = MediaQuery.of(context).size.width;
    final double _height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: PageView.builder(
      controller: PageController(
          initialPage: mSelectedPosition, keepPage: true, viewportFraction: 1),
      itemCount: list.length,
      onPageChanged: (index) {
        setState(() {
          mSelectedPosition = index;
        });
      },
      itemBuilder: (context, i) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(20, 60, 20, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'En',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color.fromRGBO(132, 15, 15, 1),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: _width * 0.7,
                  child: Image.asset(
                    list[mSelectedPosition].image!,
                    width: _width * 1.5,
                    height: _height * 0.49,
                    fit: BoxFit.contain,
                  ),
                ),
                Container(
                    width: _width / 1.25,
                    padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                    child: Text(
                      list[mSelectedPosition].title!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20,
                        height: 1.40,
                      ),
                    )),
                Container(
                    width: _width / 1.9,
                    padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
                    child: Text(
                      list[mSelectedPosition].subtitle!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Color.fromRGBO(87, 87, 87, 1),
                          fontSize: 15,
                          height: 1.40),
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 80.0),
                  child: DotsIndicator(
                    index: mSelectedPosition,
                    count: list.length,
                    accentColor: Color.fromRGBO(132, 15, 15, 0.1),
                  ),
                ),
              ],
            ),
            Container(
              width: _width,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Visibility(
                      visible: i == 0,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => App()),
                          );
                        },
                        child: Text(
                          'تخطي',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color.fromRGBO(132, 15, 15, 1),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: Color.fromRGBO(132, 15, 15, 1),
                      ),
                      onPressed: () {
                        mSelectedPosition + 1 == list.length
                            ? Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => App()),
                              )
                            : setState(() {
                                mSelectedPosition = mSelectedPosition + 1;
                              });
                      },
                    )
                  ],
                ),
              ),
            )
          ],
        );
      },
    ));
  }
}
