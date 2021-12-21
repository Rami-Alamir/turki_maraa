import 'package:flutter/material.dart';

class AddressContainer extends StatelessWidget {
  final String title;

  const AddressContainer({required this.title});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        color: Colors.transparent,
        child: Stack(
          children: [
            Container(
              color: Theme.of(context).backgroundColor == Colors.black
                  ? Theme.of(context).colorScheme.secondary
                  : Theme.of(context).primaryColor,
              height: 35,
            ),
            Positioned(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                    color: Theme.of(context).backgroundColor,
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context)
                            .colorScheme
                            .secondaryVariant
                            .withOpacity(0.3),
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
                                .headline1!
                                .copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal)),
                        Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: Theme.of(context).textTheme.subtitle2!.color,
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
      ),
    );
  }
}
