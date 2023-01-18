import 'package:flutter/material.dart';
import '../../../core/utilities/size_config.dart';

class AboutText extends StatelessWidget {
  final String title;
  final EdgeInsets padding;
  const AboutText({Key? key, required this.title, required this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: FittedBox(
        fit: BoxFit.cover,
        child: SizedBox(
          width: SizeConfig.screenWidth! - 40,
          child: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .subtitle2!
                .copyWith(height: 1.5, fontWeight: FontWeight.normal),
          ),
        ),
      ),
    );
  }
}
