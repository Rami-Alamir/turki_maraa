import 'package:flutter/material.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/widgets/order/indicator.dart';

class OrderTracking extends StatelessWidget {
  final int? statusCode;
  OrderTracking({required this.statusCode});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Indicator(
            title: AppLocalizations.of(context)!.tr('confirmed'),
            color: statusCode! > 0 ? color1 : color3,
            color2: statusCode! == 0
                ? color3
                : statusCode == 1
                    ? color2
                    : color1,
            icon: Icons.confirmation_num_outlined,
          ),
          Indicator(
            title: AppLocalizations.of(context)!.tr('preparing'),
            color: getColor1(1),
            color2: getColor2(1),
            icon: Icons.sync_problem_sharp,
          ),
          Indicator(
            title: AppLocalizations.of(context)!.tr('quality_test'),
            color: getColor1(2),
            color2: getColor2(2),
            icon: Icons.fact_check_outlined,
          ),
          Indicator(
            title: AppLocalizations.of(context)!.tr('out_for_delivery'),
            color: getColor1(3),
            color2: getColor2(3),
            icon: Icons.delivery_dining,
          ),
          Indicator(
            title: AppLocalizations.of(context)!.tr('delivered'),
            withLine: false,
            color: statusCode! > 5 ? Colors.green : Colors.grey,
            color2: statusCode! > 5 ? Colors.green : Colors.grey,
            icon: Icons.done_all,
          ),
        ],
      ),
    );
  }

  final color1 = Color.fromRGBO(107, 0, 0, 1);
  final color2 = Colors.amber;
  final color3 = Colors.grey;

  Color getColor1(int code) {
    return statusCode! > code
        ? color1
        : statusCode! == code
            ? color2
            : color3;
  }

  Color getColor2(int code) {
    return statusCode! > code + 1
        ? color1
        : statusCode! == code + 1
            ? color2
            : color3;
  }
}
