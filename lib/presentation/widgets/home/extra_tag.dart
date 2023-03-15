import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

class ExtraTag extends StatelessWidget {
  final String title;
  final bool selected;
  final Function onTap;
  const ExtraTag(
      {Key? key,
      required this.title,
      required this.selected,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Container(
            constraints: const BoxConstraints(minHeight: 40),
            decoration: BoxDecoration(
              color: !selected
                  ? Theme.of(context).colorScheme.secondaryContainer
                  : Theme.of(context).colorScheme.primary,
              shape: BoxShape.rectangle,
              borderRadius: const BorderRadius.all(Radius.circular(5)),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title.toString(),
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(
                              color: selected
                                  ? AppColors.white
                                  : Theme.of(context)
                                      .textTheme
                                      .displayLarge!
                                      .color,
                              fontSize: 14,
                              fontWeight: FontWeight.normal)),
                ],
              ),
            )),
      ),
    );
  }
}
