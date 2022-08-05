import 'package:flutter/material.dart';

class RoundedRectangleButton extends StatelessWidget {
  final String title;
  final Function? onPressed;
  final double fontSize;
  final double width;
  final double height;
  final EdgeInsets padding;
  final Color? color;
  final Color fontColor;

  const RoundedRectangleButton({
    required this.title,
    required this.onPressed,
    this.fontSize = 18,
    this.width = 320,
    this.padding = const EdgeInsets.all(25.0),
    this.height = 55,
    this.color,
    this.fontColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    Color _color = Theme.of(context).primaryColor;

    return Padding(
      padding: padding,
      child: RawMaterialButton(
        constraints: BoxConstraints.tight(Size(width, height)),
        onPressed: onPressed == null
            ? null
            : () {
                onPressed!();
              },
        elevation: 00.0,
        splashColor: color ?? _color,
        focusElevation: 0,
        highlightColor: color ?? _color,
        fillColor: onPressed == null ? Colors.grey : color ?? _color,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(const Radius.circular(5))),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .headline3
              ?.copyWith(fontSize: fontSize, color: fontColor),
        ),
      ),
    );
  }
}
