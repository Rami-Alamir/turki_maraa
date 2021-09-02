import 'package:flutter/material.dart';
import 'package:new_turki/screens/item_details.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:new_turki/widgets/shared/main_container.dart';

import '../rounded_rectangle_button.dart';

class CartCard extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  final int qty;
  final double price;

  const CartCard(
      {required this.image,
      required this.title,
      required this.subtitle,
      required this.qty,
      required this.price});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ItemDetails()),
          );
        },
        child: MainContainer(
          padding: const EdgeInsets.symmetric(vertical: 18.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    child: Image.network(
                      image,
                      width: 110,
                      height: 110,
                      fit: BoxFit.fill,
                    )),
              ),
              Padding(
                padding:
                    const EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 0.0, 0.0),
                child: Container(
                  width: SizeConfig.screenWidth! -
                      60 -
                      SizeConfig.screenWidth! / 3.8,
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
                              Text(title,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700)),
                              // Padding(
                              //   padding: const EdgeInsets.only(left: 15.0),
                              //   child: Container(
                              //     width: 17.5,
                              //     height: 17.5,
                              //     decoration: BoxDecoration(
                              //       shape: BoxShape.circle,
                              //       color: Colors.grey, // inner circle color
                              //     ),
                              //     child: Row(
                              //       mainAxisAlignment: MainAxisAlignment.center,
                              //       crossAxisAlignment:
                              //           CrossAxisAlignment.center,
                              //       children: [
                              //         Text('X',
                              //             style: TextStyle(
                              //                 color: Colors.white,
                              //                 fontSize: 10,
                              //                 height: 1.3,
                              //                 fontWeight: FontWeight.w700)),
                              //       ],
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Text(subtitle,
                                style: TextStyle(
                                    height: 1.5,
                                    color: Colors.black,
                                    fontSize: 12)),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              RoundedRectangleButton(
                                padding: EdgeInsets.all(0),
                                onPressed: () {},
                                width: 30,
                                height: 30,
                                fontSize: 18,
                                title: '-',
                              ),
                              Text(
                                '$qty',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1
                                    ?.copyWith(fontSize: 14),
                              ),
                              RoundedRectangleButton(
                                onPressed: () {},
                                padding: EdgeInsets.all(0),
                                width: 30,
                                height: 30,
                                fontSize: 18,
                                title: '+',
                              )
                            ],
                          ),
                          Text(
                            '$price ريال ',
                            style:
                                Theme.of(context).textTheme.headline1?.copyWith(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
