import 'package:flutter/material.dart';

class AddressRow extends StatelessWidget {
  final Function onTap;
  final String title;
  final bool selected;
  final bool divider;

  const AddressRow(
      {Key? key,
      required this.title,
      this.divider = true,
      required this.onTap,
      this.selected = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          onTap();
        },
        splashColor: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(title,
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge!
                      .copyWith(fontSize: 14, fontWeight: FontWeight.normal)),
            ),
            divider
                ? Divider(
                    indent: 20,
                    endIndent: 20,
                    height: 2,
                    color: Theme.of(context)
                        .colorScheme
                        .secondaryContainer
                        .withOpacity(0.3),
                  )
                : const Padding(
                    padding: EdgeInsets.all(4.0),
                  ),
          ],
        ));
  }
}
