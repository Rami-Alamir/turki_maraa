import 'package:flutter/material.dart';
import '../../../core/constants/fixed_assets.dart';
import '../../../core/constants/route_constants.dart';
import '../../../core/utilities/size_config.dart';
import 'package:provider/provider.dart';
import '../../../controllers/orders_provider.dart';
import '../../../controllers/user_provider.dart';
import 'state_item.dart';

class ProfileState extends StatelessWidget {
  const ProfileState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserProvider user = Provider.of<UserProvider>(context);
    final OrdersProvider ordersProvider = Provider.of<OrdersProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: SizeConfig.screenWidth! * .85,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                StateItem(
                    icon: FixedAssets.orders,
                    routeName: orders,
                    value: (ordersProvider.ordersData?.data?.length ?? 0) * 1.0,
                    title: 'orders'),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 50,
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    width: 0.2,
                  ),
                ),
                StateItem(
                    icon: FixedAssets.points,
                    // routeName: "/UserPoints",
                    value: double.parse(user.userData?.data?.points ?? "0"),
                    title: 'my_points'),
                Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: 50,
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      width: 0.2,
                    )),
                StateItem(
                    icon: FixedAssets.wallet,
                    // routeName: "/UserWallet",
                    value: double.parse(user.userData?.data?.wallet ?? "0"),
                    title: 'credit'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
