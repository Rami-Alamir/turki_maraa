import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SpinkitIndicator extends StatelessWidget {
  final EdgeInsets padding;

  const SpinkitIndicator(
      {Key? key, this.padding = const EdgeInsets.only(top: 0.0)})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: padding,
        child: SpinKitPulse(
          color: Theme.of(context).colorScheme.primary,
          size: 30.0,
        ),
      ),
    );
  }
}
