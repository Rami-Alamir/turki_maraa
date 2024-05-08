import 'package:flutter/material.dart';
import '../../../core/utilities/size_config.dart';

class MainCard extends StatelessWidget {
  final Widget child;
  final double width;
  final double height;
  final EdgeInsetsGeometry padding;

  const MainCard(
      {super.key,
      required this.child,
      this.width = 0,
      this.height = 100,
      this.padding =
          const EdgeInsets.only(top: 5, bottom: 5, right: 10, left: 10)});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Card(
        color: Theme.of(context).colorScheme.onBackground,
        elevation: 3,
        shadowColor:
            Theme.of(context).colorScheme.onBackground.withOpacity(0.14),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(6.5))),
        child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(6.5)),
            child: Container(
                constraints: BoxConstraints(minHeight: height),
                width: SizeConfig.screenWidth,
                child: child)),
      ),
    );
  }
}
