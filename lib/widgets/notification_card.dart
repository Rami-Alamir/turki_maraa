import 'package:flutter/material.dart';
import 'package:new_turki/screens/orders/order_details.dart';
import 'package:new_turki/utilities/size_config.dart';

class NotificationCard extends StatelessWidget {
  final String image;
  final String id;
  final String date;
  final String title;
  final String subtitle;
  final String status;
  final double total;
  final TextStyle style;

  const NotificationCard(
      {required this.image,
      required this.style,
      required this.id,
      required this.title,
      required this.date,
      required this.subtitle,
      required this.status,
      required this.total});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
          height: 375,
          decoration: BoxDecoration(
            color: Theme.of(context).accentColor,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(8.0),
                topLeft: Radius.circular(8.0),
                bottomRight: Radius.circular(5.0),
                bottomLeft: Radius.circular(5.0)),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context)
                    .textTheme
                    .headline4!
                    .color!
                    .withOpacity(0.15),
                spreadRadius: 0.5,
                blurRadius: 11,
              ),
            ],
          ),
          child: Column(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.all(const Radius.circular(8)),
                  child: Container(
                    width: SizeConfig.screenWidth,
                    height: 255,
                    child: Image.network(
                      image,
                      width: SizeConfig.screenWidth,
                      height: 255,
                      fit: BoxFit.fill,
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: SizeConfig.screenWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(
                                  fontSize: 14, fontWeight: FontWeight.w600)),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(subtitle,
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(
                                    height: 1.45,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: Container(
                          width: SizeConfig.screenWidth,
                          child: Text(date,
                              textAlign: TextAlign.end,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400)),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
