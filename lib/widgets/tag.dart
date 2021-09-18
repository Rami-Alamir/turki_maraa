import 'package:flutter/material.dart';

class Tag extends StatelessWidget {
  final title;
  final selected;
  final onTap;
  const Tag({required this.title, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Container(
            decoration: BoxDecoration(
              color: !selected
                  ? Colors.transparent
                  : Theme.of(context).primaryColor,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(5)),
              border: Border.all(
                color: selected
                    ? Colors.transparent
                    : Theme.of(context)
                        .textTheme
                        .headline4!
                        .color!
                        .withOpacity(0.35),
                width: 2.0,
              ),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 6.0, horizontal: 15),
              child: Text(title.toString(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline4?.copyWith(
                      color: selected
                          ? Colors.white
                          : Theme.of(context).textTheme.headline6!.color,
                      fontSize: 14)),
            )),
      ),
    );
  }
}
