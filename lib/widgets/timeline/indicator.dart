import 'package:flutter/material.dart';
import 'package:new_turki/widgets/timeline/container.dart';

class Indicator extends StatelessWidget {
  final Color color;
  final Color color2;
  final IconData icon;
  final String title;
  final bool withLine;

  const Indicator(
      {required this.color,
      required this.color2,
      this.withLine = true,
      required this.icon,
      required this.title});

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
          child: Container(
            width: 45,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(fontWeight: FontWeight.normal, fontSize: 10),
            ),
          ),
        ),
      ],
    );
  }
}
