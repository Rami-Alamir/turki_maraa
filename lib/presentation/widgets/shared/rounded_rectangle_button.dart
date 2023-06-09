import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class RoundedRectangleButton extends StatelessWidget {
  final String title;
  final Function? onPressed;
  final double fontSize;
  final double width;
  final double height;
  final EdgeInsets padding;
  final Color? color;
  final Color? fontColor;
  final double fontHeight;

  const RoundedRectangleButton({
    Key? key,
    required this.title,
    this.onPressed,
    this.fontSize = 18,
    this.width = 320,
    this.padding = const EdgeInsets.all(25.0),
    this.height = 55,
    this.color,
    this.fontColor,
    this.fontHeight = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        focusElevation: 0,
        fillColor: onPressed == null
            ? AppColors.grey
            : color ?? Theme.of(context).colorScheme.tertiaryContainer,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontSize: fontSize, color: fontColor, height: fontHeight),
        ),
      ),
    );
  }
}
