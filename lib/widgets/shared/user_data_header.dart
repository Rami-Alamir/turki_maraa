import 'package:flutter/material.dart';
import 'package:new_turki/models/user.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/r_a7_i_c_o_n_s_icons.dart';

class UserDataHeader extends StatelessWidget {
  final User user;
  final bool isAuth;
  const UserDataHeader({required this.user, required this.isAuth});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:
            const EdgeInsets.only(right: 15.0, left: 15, top: 30, bottom: 20),
        child: isAuth
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Theme.of(context).primaryColor,
                    child: Text(user.name!.substring(0, 1),
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          user.name!,
                          style: Theme.of(context).textTheme.subtitle1!,
                        ),
                        Text(user.phone!,
                            style: Theme.of(context).textTheme.subtitle2)
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
                      child: Icon(
                        RA7ICONS.user__1_,
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
                                  .pushNamed(
                            '/Login',
                          ),
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
