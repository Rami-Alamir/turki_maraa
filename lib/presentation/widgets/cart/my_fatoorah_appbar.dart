import 'package:flutter/material.dart';
import '../../../core/constants/route_constants.dart';
import '../../../core/utilities/t_u_r_k_i_i_c_o_n_s_icons.dart';

class MyFatoorahAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyFatoorahAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.onSurface,

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
                icon: Icon(
                  TURKIICONS.x2,
                  size: 15,
                  color: Theme.of(context).colorScheme.primary,
                ),
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
