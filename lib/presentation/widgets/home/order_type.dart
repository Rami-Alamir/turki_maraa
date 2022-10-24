import 'package:flutter/material.dart';
import '../../../core/utilities/size_config.dart';
import '../../../core/utilities/t_u_r_k_i_i_c_o_n_s_icons.dart';
import '../profile/order_type_item.dart';

class OrderType extends StatelessWidget {
  final bool visible;
  final Color? color;

  const OrderType({Key? key, required this.visible, this.color})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 105,
      color: Theme.of(context).backgroundColor == Colors.black
          ? Theme.of(context).colorScheme.secondary
          : color ?? Theme.of(context).primaryColor,
      child: visible
          ? Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: SizedBox(
                    width: SizeConfig.screenWidth,
                    height: 72,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        OrderTypeItem(
                            type: 0,
                            title: 'delivery',
                            icon: TURKIICONS.delivery_truck_2),
                        OrderTypeItem(
                            type: 1,
                            title: 'pickup',
                            icon: TURKIICONS.merchant_1),
                      ],
                    ),
                  ),
                ),
              ],
            )
          : Container(),
    );
  }
}