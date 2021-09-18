import 'package:flutter/material.dart';
import 'package:new_turki/utilities/size_config.dart';

class PromoCode extends StatelessWidget {
  final int promoStatus;
  final TextEditingController controller;

  const PromoCode({required this.promoStatus, required this.controller});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: Text(
            'برومو كود',
            style:
                Theme.of(context).textTheme.headline1!.copyWith(fontSize: 16),
          ),
        ),
        TextFormField(
            cursorColor: Theme.of(context).primaryColor,
            controller: controller,
            enabled: promoStatus == -1,
            style: Theme.of(context).textTheme.headline4!.copyWith(
                fontSize: 18.0, height: 0.7, fontWeight: FontWeight.normal),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 15.0),
              suffix: GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'تفعيل',
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(fontSize: 12, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      color: Theme.of(context)
                          .textTheme
                          .headline4!
                          .color!
                          .withOpacity(0.35),
                      width: 1)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      color: promoStatus == 0
                          ? Colors.red
                          : Theme.of(context)
                              .textTheme
                              .headline4!
                              .color!
                              .withOpacity(0.35),
                      width: controller.text.length > 0 ? 1 : 0.35)),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                    color: promoStatus == 0
                        ? Colors.red
                        : Theme.of(context)
                            .textTheme
                            .headline4!
                            .color!
                            .withOpacity(0.35),
                    width: 0.35),
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: promoStatus == 0
                        ? Colors.red
                        : Theme.of(context)
                            .textTheme
                            .headline4!
                            .color!
                            .withOpacity(0.35),
                  )),
            )),
      ],
    );
  }
}
