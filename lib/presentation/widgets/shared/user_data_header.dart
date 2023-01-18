import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/route_constants.dart';
import '../../../controllers/auth.dart';
import '../../../controllers/user_provider.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/t_u_r_k_i_i_c_o_n_s_icons.dart';

class UserDataHeader extends StatelessWidget {
  const UserDataHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Auth auth = Provider.of<Auth>(context);
    final UserProvider user = Provider.of<UserProvider>(context);
    return Padding(
        padding:
            const EdgeInsets.only(right: 15.0, left: 15, top: 30, bottom: 20),
        child: auth.isAuth
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Theme.of(context).primaryColor,
                    child: Text(
                        (user.userData?.data?.name ?? "").isNotEmpty
                            ? (user.userData?.data?.name ?? "").substring(0, 1)
                            : "",
                        style:
                            const TextStyle(fontSize: 20, color: Colors.white)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          user.userData?.data?.name ?? "",
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: Text(user.userData?.data?.mobile ?? "",
                              style: Theme.of(context).textTheme.subtitle2),
                        )
                      ],
                    ),
                  )
                ],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                      radius: 30,
                      backgroundColor: Theme.of(context).primaryColor,
                      child: const Icon(
                        TURKIICONS.user6,
                        color: Colors.white,
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10),
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
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ));
  }
}
