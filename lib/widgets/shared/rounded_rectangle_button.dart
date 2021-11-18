import 'package:flutter/material.dart';

class RoundedRectangleButton extends StatelessWidget {
  final String title;
  final Function onPressed;
  final double fontSize;
  final double width;
  final double height;
  final EdgeInsets padding;

  const RoundedRectangleButton(
      {required this.title,
      required this.onPressed,
      this.fontSize = 18,
      this.width = 320,
      this.padding = const EdgeInsets.all(25.0),
      this.height = 55});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: RawMaterialButton(
        constraints: BoxConstraints.tight(Size(width, height)),
        onPressed: () {
          onPressed();
        },
        elevation: 10.0,
        splashColor: Color.fromRGBO(107, 0, 0, 1),
        focusElevation: 0,
        highlightColor: Color.fromRGBO(107, 0, 0, 1),
        fillColor: Color.fromRGBO(107, 0, 0, 1),
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
