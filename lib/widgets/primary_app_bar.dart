import 'package:flutter/material.dart';
import 'package:new_turki/utilities/r_a7_i_c_o_n_s_icons.dart';
import 'logo.dart';

class PrimaryAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool back;
  final bool action;
  final IconData icon;
  final String? title;

  const PrimaryAppBar(
      {this.back = true,
      this.action = false,
      this.title,
      this.icon = Icons.notifications_active_outlined});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        title: title != null
            ? Text(
                title!,
                style: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 16),
              )
            : Logo(),
        centerTitle: true,
        leading: Visibility(
          visible: back,
          child: Container(
            width: 55,
            height: 66,
            child: IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              icon: Icon(Icons.arrow_back_ios,
                  color: Theme.of(context).primaryColor),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ),
        actions: [
          Visibility(
            visible: action,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                icon,
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
