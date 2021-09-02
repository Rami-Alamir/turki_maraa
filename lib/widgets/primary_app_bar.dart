import 'package:flutter/material.dart';
import 'package:new_turki/utilities/r_a7_i_c_o_n_s_icons.dart';
import 'logo.dart';

class PrimaryAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool back;
  final bool search;
  final String? title;

  const PrimaryAppBar({this.back = true, this.search = false, this.title});

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
          child: IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            icon: Icon(Icons.arrow_back_ios,
                color: Theme.of(context).primaryColor),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        actions: [
          Visibility(
            visible: search,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                RA7ICONS.search,
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
