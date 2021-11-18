import 'package:flutter/material.dart';
import 'logo.dart';

class PrimaryAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool back;
  final Widget action;
  final String? title;

  PrimaryAppBar(
      {this.back = true,
      this.action = const SizedBox(
        width: 0,
        height: 0,
      ),
      this.title});

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
        actions: [action],
        elevation: 0.0,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(55);
}
