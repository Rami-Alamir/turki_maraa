import 'package:flutter/material.dart';
import 'logo.dart';

class PrimaryAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool back;
  final Widget action;
  final String? title;
  final bool isTransparent;
  const PrimaryAppBar(
      {super.key,
      this.back = true,
      this.action = const SizedBox(
        width: 0,
        height: 0,
      ),
      this.isTransparent = false,
      this.title});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: AppBar(
        backgroundColor: isTransparent
            ? Colors.transparent
            : Theme.of(context).colorScheme.background,
        title: title != null
            ? Text(
                title!,
                style: Theme.of(context).textTheme.titleSmall,
              )
            : const Logo(),
        centerTitle: true,
        leading: Visibility(
          visible: back,
          child: SizedBox(
            width: 55,
            height: 66,
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios,
                  color: Theme.of(context).colorScheme.primary),
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
  Size get preferredSize => const Size.fromHeight(55);
}
