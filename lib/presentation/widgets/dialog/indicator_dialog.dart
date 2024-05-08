import 'package:flutter/material.dart';
import '../shared/spinkit_indicator.dart';

class IndicatorDialog extends StatelessWidget {
  const IndicatorDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Container(
        color: Colors.transparent,
        child: const Center(child: SpinkitIndicator()));
  }
}
