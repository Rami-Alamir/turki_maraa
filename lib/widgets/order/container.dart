import 'package:flutter/material.dart';

class Line extends StatelessWidget {
  final Color color1;
  final Color color2;

  const Line({required this.color1, required this.color2});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0.0),
      child: Container(
        width: 30,
        height: 4,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.bottomLeft,
            colors: [
              color1,
              color2,
            ],
          ),
        ),
      ),
    );
  }
}
