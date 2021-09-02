import 'package:flutter/material.dart';

class AddressContainer extends StatelessWidget {
  final String title;

  const AddressContainer({required this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                color: Theme.of(context).primaryColor,
                height: 35,
              ),
              Container(
                color: Colors.transparent,
                // color: Theme.of(context).backgroundColor,
                height: 35,
              ),
            ],
          ),
          Positioned(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(7)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 6,
                      spreadRadius: 0.5,
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(title,
                          style: Theme.of(context)
                              .textTheme
                              .headline2!
                              .copyWith(fontSize: 14)),
                      Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Color.fromRGBO(87, 87, 87, 1),
                        size: 35,
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
