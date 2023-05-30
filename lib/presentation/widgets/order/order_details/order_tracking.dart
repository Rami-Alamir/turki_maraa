import 'package:flutter/material.dart';
import '../../../../core/utilities/app_localizations.dart';
import 'indicator.dart';

class OrderTracking extends StatelessWidget {
  final int? statusCode;
  const OrderTracking({Key? key, required this.statusCode}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Indicator(
            title: AppLocalizations.of(context)!.tr('confirmed'),
            color: statusCode! > 100 ? color1 : color3,
            color2: statusCode! == 100
                ? color3
                : statusCode == 101
                    ? color2
                    : color1,
            icon: Icons.confirmation_num_outlined,
          ),
          Indicator(
            title: AppLocalizations.of(context)!.tr('preparing'),
            color: getColor1(102),
            color2: getColor2(102),
            icon: Icons.sync_problem_sharp,
          ),
          Indicator(
            title: AppLocalizations.of(context)!.tr('quality_test'),
            color: getColor1(103),
            color2: getColor2(103),
            icon: Icons.fact_check_outlined,
          ),
          Indicator(
            title: AppLocalizations.of(context)!.tr('out_for_delivery'),
            color: getColor1(104),
            color2: getColor2(104),
            icon: Icons.delivery_dining,
          ),
          Indicator(
            title: AppLocalizations.of(context)!
                .tr(statusCode! == 4000 ? 'canceled' : 'delivered'),
            withLine: false,
            color: statusCode! != 200
                ? statusCode! == 4000
                    ? Colors.red
                    : Colors.grey
                : Colors.green,
            color2: statusCode! != 200
                ? statusCode! == 4000
                    ? Colors.red
                    : Colors.grey
                : Colors.green,
            icon: Icons.done_all,
          ),
        ],
      ),
    );
  }

  final color1 = const Color.fromRGBO(90, 4, 9, 1);
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
