import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SpinkitIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 60.0),
        child: SpinKitPulse(
          color: Theme.of(context).primaryColor,
          size: 30.0,
        ),
      ),
    );
  }
}
