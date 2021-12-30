import 'package:flutter/material.dart';
import 'package:new_turki/provider/auth.dart';
import 'package:new_turki/screens/profile/login.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/r_a7_i_c_o_n_s_icons.dart';
import 'package:provider/provider.dart';

class UserDataHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<Auth>(context);

    return Padding(
        padding:
            const EdgeInsets.only(right: 15.0, left: 15, top: 30, bottom: 20),
        child: _auth.isAuth
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Theme.of(context).primaryColor,
                    child: Text(
                        ((_auth.userData.data!.name)?.length ?? 0) > 0
                            ? (_auth.userData.data!.name!).substring(0, 1)
                            : "",
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
                          _auth.userData.data!.name ?? "",
                          style: Theme.of(context).textTheme.subtitle1!,
                        ),
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: Text(_auth.userData.data?.mobile ?? "",
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
                              Navigator.of(context, rootNavigator: true).push(
                            MaterialPageRoute(
                                builder: (BuildContext context) => Login()),
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
