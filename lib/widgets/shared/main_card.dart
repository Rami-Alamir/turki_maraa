import 'package:flutter/material.dart';
import 'package:new_turki/screens/item_details.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:new_turki/widgets/shared/main_container.dart';

import '../rounded_rectangle_button.dart';

class MainCard extends StatelessWidget {
  final Widget child;
  final double width;
  final double height;
  final EdgeInsetsGeometry padding;

  MainCard(
      {required this.child,
      this.width = 0,
      this.height = 150,
      this.padding =
          const EdgeInsets.only(top: 5, bottom: 5, right: 10, left: 10)});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: padding,
        child: Card(
          color: Colors.white,
          elevation: 1,
          shadowColor: Colors.grey.withOpacity(0.15),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(6.5))),
          child: ClipRRect(
              borderRadius: BorderRadius.all(const Radius.circular(6.5)),
              child: Container(
                  constraints: BoxConstraints(minHeight: height),
                  width: SizeConfig.screenWidth,
                  child: child)),
        ),
      ),
    );
  }
}
