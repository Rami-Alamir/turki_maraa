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
            constraints: BoxConstraints(minHeight: 40),
            decoration: BoxDecoration(
              color: !selected
                  ? Color.fromRGBO(240, 240, 240, 1)
                  : Theme.of(context).primaryColor,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 0.0, horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title.toString(),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline4?.copyWith(
                          color: selected
                              ? Colors.white
                              : Theme.of(context).textTheme.headline6!.color,
                          fontSize: 14,
                          fontWeight: FontWeight.normal)),
                ],
              ),
            )),
      ),
    );
  }
}
