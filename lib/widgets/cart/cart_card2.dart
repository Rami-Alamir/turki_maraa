import 'package:flutter/material.dart';
import 'package:new_turki/screens/item_details.dart';
import 'package:new_turki/utilities/size_config.dart';

import '../rounded_rectangle_button.dart';

class CartCard2 extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  final int qty;
  final double price;

  const CartCard2(
      {required this.image,
      required this.title,
      required this.subtitle,
      required this.qty,
      required this.price});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ItemDetails()),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.network(
                      image,
                      width: SizeConfig.screenWidth! / 3.80,
                      height: SizeConfig.screenWidth! / 3.85,
                      fit: BoxFit.cover,
                    )),
              ),
              Padding(
                padding:
                    const EdgeInsetsDirectional.fromSTEB(10.0, 5.0, 0.0, 0.0),
                child: Container(
                  width: SizeConfig.screenWidth! -
                      50 -
                      SizeConfig.screenWidth! / 3.8,
                  constraints: BoxConstraints(minHeight: 110),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(title,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700)),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Text(subtitle,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 12)),
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
                                fontSize: 22,
                                title: '-',
                              ),
                              Text(
                                '$qty',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1
                                    ?.copyWith(fontSize: 16),
                              ),
                              RoundedRectangleButton(
                                onPressed: () {},
                                padding: EdgeInsets.all(0),
                                width: 30,
                                height: 30,
                                fontSize: 22,
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
