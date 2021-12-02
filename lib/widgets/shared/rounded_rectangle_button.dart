import 'package:flutter/material.dart';

class RoundedRectangleButton extends StatelessWidget {
  final String title;
  final Function onPressed;
  final double fontSize;
  final double width;
  final double height;
  final EdgeInsets padding;
  final Color color;

  const RoundedRectangleButton(
      {required this.title,
      required this.onPressed,
      this.fontSize = 18,
      this.width = 320,
      this.padding = const EdgeInsets.all(25.0),
      this.height = 55,
      this.color = const Color.fromRGBO(107, 0, 0, 1)});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: RawMaterialButton(
        constraints: BoxConstraints.tight(Size(width, height)),
        onPressed: () {
          onPressed();
        },
        elevation: 00.0,
        splashColor: color,
        focusElevation: 0,
        highlightColor: color,
        fillColor: color,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(const Radius.circular(5))),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .headline3
              ?.copyWith(fontSize: fontSize),
        ),
      ),
    );
  }
}
