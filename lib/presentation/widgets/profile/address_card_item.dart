import 'package:flutter/material.dart';
import '../../../core/utilities/size_config.dart';

class AddressCardItem extends StatelessWidget {
  final String title;
  final Function onTap;
  const AddressCardItem({Key? key, required this.title, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: SizedBox(
        width: SizeConfig.screenWidth! / 2 - 15,
        child: Text(
          title,
          textAlign: TextAlign.center,
          style:
              Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 12),
        ),
      ),
    );
  }
}
