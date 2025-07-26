import 'package:flutter/material.dart';
import '../../../core/constants/route_constants.dart';

class MyFatoorahAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyFatoorahAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                onPressed: () {
                  Navigator.pushReplacementNamed(
                    context,
                    orderStatus,
                    arguments: false,
                  );
                },
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                icon: const Icon(Icons.arrow_back_ios, size: 15),
              ),
            ],
          ),
        ),
      ),
      elevation: 0,
      automaticallyImplyLeading: false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(45);
}
