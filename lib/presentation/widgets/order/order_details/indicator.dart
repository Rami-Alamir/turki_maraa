import 'package:flutter/material.dart';

import 'line.dart';

// used in order_tracking
class Indicator extends StatelessWidget {
  final Color color;
  final Color color2;
  final IconData icon;
  final String title;
  final bool withLine;

  const Indicator(
      {Key? key,
      required this.color,
      required this.color2,
      this.withLine = true,
      required this.icon,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color.withOpacity(0.25), // border color
                shape: BoxShape.circle,
              ),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color, // inner circle color
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 16,
                ), // inner content
              ),
            ),
            Visibility(
                visible: withLine,
                child: Line(
                    color1: color2 == Colors.grey ? color2 : color,
                    color2: color2)),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 6.0),
          child: SizedBox(
            width: 45,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(fontWeight: FontWeight.normal, fontSize: 10),
            ),
          ),
        ),
      ],
    );
  }
}
