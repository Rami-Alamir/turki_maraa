import 'package:flutter/material.dart';
import 'order_type_item.dart';
import '../../../../core/utilities/size_config.dart';
import '../../../../core/utilities/t_u_r_k_i_i_c_o_n_s_icons.dart';

class OrderType extends StatelessWidget {
  final Color? color;

  const OrderType({super.key, this.color});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: SizedBox(
            width: SizeConfig.screenWidth,
            height: SizeConfig.setWidgetHeight(72, 100, 100),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OrderTypeItem(
                    type: 0,
                    title: 'delivery',
                    icon: TURKIICONS.delivery_truck_2),
                OrderTypeItem(
                    type: 1, title: 'pickup', icon: TURKIICONS.merchant_1),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
