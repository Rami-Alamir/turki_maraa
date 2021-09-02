import 'package:flutter/material.dart';

class FaqRow extends StatefulWidget {
  final question;
  final answer;

  const FaqRow({@required this.question, @required this.answer});
  @override
  _FaqRowState createState() => _FaqRowState();
}

class _FaqRowState extends State<FaqRow> {
  bool selected = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        color: Colors.white,
        duration: Duration(microseconds: 1),
        child: Column(
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
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 15),
            ),
            Visibility(
              visible: selected,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Text(
                  widget.answer,
                  textAlign: TextAlign.start,
                  style: Theme.of(context)
                      .textTheme
                      .headline2!
                      .copyWith(fontSize: 14),
                ),
              ),
            ),
            Divider(
              indent: 0,
              height: 1,
              color: Colors.grey,
            )
          ],
        ));
  }
}
