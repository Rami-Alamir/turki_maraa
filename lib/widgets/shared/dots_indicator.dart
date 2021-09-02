import 'package:flutter/material.dart';

class DotsIndicator extends StatelessWidget {
  final int index;
  final int count;
  final Color accentColor;

  const DotsIndicator(
      {required this.index, required this.count, required this.accentColor});
  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center, children: _buildDotsRow());
  }

  List<Widget> _buildDotsRow() {
    List<Widget> dots = []; // this will hold Rows according to available lines
    for (int i = 0; i < count; i++) {
      dots.add(Padding(
        padding: const EdgeInsets.all(3.0),
        child: Container(
          height: 4,
          width: i == index ? 30 : 8,
          decoration: new BoxDecoration(
            color: i == index ? Color.fromRGBO(132, 15, 15, 1) : accentColor,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(0.75)),
          ),
        ),
      ));
    }
    return dots;
  }
}
