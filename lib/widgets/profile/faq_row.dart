import 'package:flutter/material.dart';
import 'package:new_turki/widgets/shared/main_card.dart';

class FaqRow extends StatefulWidget {
  final question;
  final answer;

  const FaqRow({required this.question, required this.answer});
  @override
  _FaqRowState createState() => _FaqRowState();
}

class _FaqRowState extends State<FaqRow> {
  bool selected = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        duration: Duration(microseconds: 1),
        child: MainCard(
          height: 60,
          padding: EdgeInsets.only(top: 2.5, bottom: 0, right: 10, left: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                focusColor: Colors.transparent,
                onTap: () {
                  setState(() {
                    selected = !selected;
                  });
                },
                dense: true,
                title: Text(
                  widget.question,
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(fontSize: 12, fontWeight: FontWeight.w600),
                ),
                trailing: Icon(
                  selected ? Icons.remove : Icons.add,
                  size: 20,
                  color: Theme.of(context).textTheme.headline6!.color,
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 15),
              ),
              Visibility(
                visible: selected,
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 15, bottom: 20, left: 15, top: 5),
                  child: Text(
                    widget.answer,
                    textAlign: TextAlign.start,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
