import 'package:flutter/material.dart';
import 'package:new_turki/provider/auth.dart';
import 'package:new_turki/provider/orders_provider.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:new_turki/widgets/shared/main_card.dart';
import 'package:new_turki/widgets/shared/user_data_header.dart';
import 'package:provider/provider.dart';
import 'profile_state.dart';

class ProfileHeader extends StatelessWidget {
  final bool isAuth;

  const ProfileHeader({required this.isAuth});
  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<Auth>(context);
    final _orders = Provider.of<OrdersProvider>(context);
    return MainCard(
        width: SizeConfig.screenWidth!,
        padding: EdgeInsets.only(bottom: 0, right: 7, left: 7),
        child: Column(
          children: [
            UserDataHeader(),
            if (isAuth)
              ProfileState(
                  user: _auth.userData,
                  orders: (_orders.ordersData?.data?.length ?? 0)),
          ],
        ));
  }
}
