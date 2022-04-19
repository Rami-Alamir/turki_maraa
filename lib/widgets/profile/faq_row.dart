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
  bool _selected = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MainCard(
          height: 65,
          padding:
              const EdgeInsets.only(top: 2.5, bottom: 0, right: 10, left: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                focusColor: Colors.transparent,
                onTap: () {
                  setState(() {
                    _selected = !_selected;
                  });
                },
                dense: true,
                title: Text(
                  widget.question,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(fontSize: 12, fontWeight: FontWeight.w600),
                ),
                trailing: Icon(
                  _selected
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  size: 20,
                  color: Theme.of(context)
                      .textTheme
                      .headline6!
                      .color!
                      .withOpacity(0.5),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 15),
              ),
            ],
          ),
        ),
        Visibility(
          visible: _selected,
          child: Padding(
            padding:
                const EdgeInsets.only(right: 20, bottom: 20, left: 20, top: 5),
            child: Text(
              widget.answer,
              textAlign: TextAlign.start,
              style:
                  Theme.of(context).textTheme.subtitle2!.copyWith(fontSize: 14),
            ),
          ),
        ),
      ],
    );
  }
}
