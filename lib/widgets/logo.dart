import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final int type;

  const Logo({this.type = 2});
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      type == 2 ? 'assets/images/turki2.png' : 'assets/images/turki.png',
      height: 29,
    );
  }
}
