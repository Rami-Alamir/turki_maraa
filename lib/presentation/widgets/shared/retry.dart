import 'package:flutter/material.dart';

class Retry extends StatelessWidget {
  final Function onPressed;
  final EdgeInsets padding;

  const Retry(
      {Key? key,
      required this.onPressed,
      this.padding = const EdgeInsets.only(top: 0.0)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: padding,
        child: IconButton(
          onPressed: () {
            onPressed();
          },
          icon: Icon(
            Icons.refresh,
            size: 30,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
