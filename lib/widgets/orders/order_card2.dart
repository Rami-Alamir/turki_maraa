import 'package:flutter/material.dart';
import 'package:new_turki/screens/item_details.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:new_turki/widgets/shared/main_card.dart';
import 'package:new_turki/widgets/shared/main_container.dart';

import '../rounded_rectangle_button.dart';

class OrderCard2 extends StatelessWidget {
  final String image;
  final String id;
  final String date;
  final String status;
  final double total;
  final TextStyle style;

  const OrderCard2(
      {required this.image,
      required this.style,
      required this.id,
      required this.date,
      required this.status,
      required this.total});
  @override
  Widget build(BuildContext context) {
    return MainCard(
      padding: const EdgeInsets.only(top: 0, bottom: 2.5, right: 10, left: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 120,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(11.0)),
                    child: ClipRRect(
                        borderRadius: BorderRadius.all(
                          Radius.circular(11),
                        ),
                        child: Image.network(
                          image,
                          width: 99,
                          height: 99,
                          fit: BoxFit.fill,
                        )),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 0.0, 0.0),
            child: Container(
              width:
                  SizeConfig.screenWidth! - 60 - SizeConfig.screenWidth! / 3.8,
              constraints: BoxConstraints(minHeight: 110),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text("رقم الطلب: ",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600)),
                              Text(id,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Text('$date',
                            style: TextStyle(
                                height: 1,
                                color: Colors.black.withOpacity(0.5),
                                fontSize: 12)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Row(
                          children: [
                            Text('$total',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black.withOpacity(0.9),
                                    fontSize: 12)),
                            Text(' ريال',
                                style: TextStyle(
                                    height: 1,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black.withOpacity(0.9),
                                    fontSize: 8)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Text(
                      status,
                      style: style,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
