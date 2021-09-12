import 'package:flutter/material.dart';
import 'package:new_turki/screens/profile/notification.dart';
import 'package:new_turki/utilities/r_a7_i_c_o_n_s_icons.dart';
import 'logo.dart';

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text(
          'حسابي',
          style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 16),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: IconButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserNotification()),
              ),
              icon: Icon(
                Icons.notifications_active_outlined,
                size: 25,
                color: Theme.of(context).primaryColor,
              ),
            ),
          )
        ],
        elevation: 0.0,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(55);
}
