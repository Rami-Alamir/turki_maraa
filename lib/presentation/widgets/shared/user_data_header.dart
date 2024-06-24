import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controllers/auth.dart';
import '../../../controllers/user_provider.dart';
import '../../../core/constants/route_constants.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/t_u_r_k_i_i_c_o_n_s_icons.dart';
import '../../../models/user_data.dart';

class UserDataHeader extends StatelessWidget {
  const UserDataHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:
            const EdgeInsets.only(right: 15.0, left: 15, top: 30, bottom: 20),
        child: context.watch<Auth>().isAuth
            ? Selector<UserProvider, Data?>(
                selector: (_, userProvider) => userProvider.userData?.data,
                builder: (_, userData, __) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor:
                            Theme.of(context).colorScheme.tertiaryContainer,
                        child: Text(
                            (userData?.name ?? "").isNotEmpty
                                ? (userData?.name ?? "").substring(0, 1)
                                : "",
                            style: TextStyle(
                                fontSize: 20,
                                color:
                                    Theme.of(context).colorScheme.onSurface)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              userData?.name ?? "",
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            Directionality(
                              textDirection: TextDirection.ltr,
                              child: Text(userData?.mobile ?? "",
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayLarge!
                                      .copyWith(height: 1.5)),
                            )
                          ],
                        ),
                      )
                    ],
                  );
                },
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                      radius: 30,
                      backgroundColor:
                          Theme.of(context).colorScheme.tertiaryContainer,
                      child: Icon(
                        TURKIICONS.user6,
                        color: Theme.of(context).colorScheme.onSurface,
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextButton(
                          onPressed: () =>
                              Navigator.of(context, rootNavigator: true)
                                  .pushNamed(login),
                          child: Text(
                            AppLocalizations.of(context)!.tr('login'),
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ));
  }
}
