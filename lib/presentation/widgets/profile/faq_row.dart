import 'package:flutter/material.dart';
import '../shared/main_card.dart';

class FaqRow extends StatefulWidget {
  final String question;
  final String answer;

  const FaqRow({Key? key, required this.question, required this.answer})
      : super(key: key);
  @override
  FaqRowState createState() => FaqRowState();
}

class FaqRowState extends State<FaqRow> {
  bool _selected = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        duration: const Duration(microseconds: 1),
        child: MainCard(
          height: 60,
          padding:
              const EdgeInsets.only(top: 7, bottom: 0, right: 10, left: 10),
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
                      .displayLarge!
                      .copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                trailing: Icon(
                  _selected ? Icons.remove : Icons.add,
                  size: 20,
                  color: Theme.of(context).textTheme.titleLarge!.color,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 15),
              ),
              Visibility(
                visible: _selected,
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 15, bottom: 20, left: 15, top: 5),
                  child: Text(
                    widget.answer,
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
