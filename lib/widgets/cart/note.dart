import 'package:flutter/material.dart';
import 'package:new_turki/utilities/size_config.dart';

class Note extends StatelessWidget {
  final int promoStatus;
  final TextEditingController controller;

  const Note({required this.promoStatus, required this.controller});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: Text(
            'ملاحظات',
            style:
                Theme.of(context).textTheme.headline1!.copyWith(fontSize: 16),
          ),
        ),
        TextFormField(
            cursorColor: Theme.of(context).primaryColor,
            controller: controller,
            enabled: promoStatus == -1,
            maxLines: 6,
            style: TextStyle(
                fontSize: 18.0,
                height: 0.7,
                color: Colors.black,
                fontWeight: FontWeight.normal),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 15.0),
              suffix: GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '',
                    style: TextStyle(
                        color: Color.fromRGBO(132, 15, 15, 1),
                        fontSize: 12,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      color: Theme.of(context).primaryColor, width: 1)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      color: promoStatus == 0
                          ? Colors.red
                          : Theme.of(context).primaryColor,
                      width: controller.text.length > 0 ? 1 : 0.35)),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                    color: promoStatus == 0 ? Colors.red : Colors.black38,
                    width: 0.35),
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      color: promoStatus == 0
                          ? Colors.red
                          : Theme.of(context).primaryColor)),
            )),
      ],
    );
  }
}
