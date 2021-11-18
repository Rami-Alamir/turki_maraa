import 'package:flutter/material.dart';
import 'package:new_turki/utilities/size_config.dart';

class MainCard extends StatelessWidget {
  final Widget child;
  final double width;
  final double height;
  final EdgeInsetsGeometry padding;

  MainCard(
      {required this.child,
      this.width = 0,
      this.height = 100,
      this.padding =
          const EdgeInsets.only(top: 5, bottom: 5, right: 10, left: 10)});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Card(
        color: Theme.of(context).colorScheme.secondary,
        elevation: 3,
        shadowColor: Theme.of(context).colorScheme.secondary.withOpacity(0.14),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(6.5))),
        child: ClipRRect(
            borderRadius: BorderRadius.all(const Radius.circular(6.5)),
            child: Container(
                constraints: BoxConstraints(minHeight: height),
                width: SizeConfig.screenWidth,
                child: child)),
      ),
    );
  }
}
