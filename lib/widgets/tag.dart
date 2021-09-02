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
                color: Colors.grey.withOpacity(0.35),
                width: 2.0,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 6),
              child: Text(title.toString(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline4?.copyWith(
                      color: selected ? Colors.white : Colors.black45)),
            )),
      ),
    );
  }
}
