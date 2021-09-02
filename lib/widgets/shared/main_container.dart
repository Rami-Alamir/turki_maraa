import 'package:flutter/material.dart';
import 'package:new_turki/utilities/size_config.dart';

class MainContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  const MainContainer(
      {required this.child, this.padding = const EdgeInsets.all(0)});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 7,
      shadowColor: Colors.grey.withOpacity(0.15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Container(
        width: SizeConfig.screenWidth,
        child: ClipRRect(
            borderRadius: BorderRadius.all(const Radius.circular(10)),
            child: Container(
                constraints: BoxConstraints(minHeight: 110),
                width: SizeConfig.screenWidth,
                color: Colors.white,
                child: child)),
      ),
    );
  }
}
