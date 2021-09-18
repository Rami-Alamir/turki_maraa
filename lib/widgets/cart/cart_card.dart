import 'package:flutter/material.dart';
import 'package:new_turki/screens/item_details.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:new_turki/widgets/shared/main_card.dart';

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
        child: MainCard(
          padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 3),
          height: 125,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    child: Container(
                      color: Theme.of(context).accentColor,
                      child: Image.network(
                        image,
                        width: 110,
                        height: 110,
                        fit: BoxFit.fill,
                      ),
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
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1!
                                      .copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700)),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Text(subtitle,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .copyWith(
                                        height: 1.5,
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal)),
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
