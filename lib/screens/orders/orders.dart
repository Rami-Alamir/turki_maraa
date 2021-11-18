import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  final bool back;

  const Orders({this.back = false});
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
