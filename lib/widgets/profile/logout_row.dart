import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../provider/auth.dart';
import '../../utilities/app_localizations.dart';

class LogOutRow extends StatelessWidget {
  final bool isAuth;

  const LogOutRow({required this.isAuth});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isAuth,
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          final _auth = Provider.of<Auth>(context, listen: false);
          _auth.logOut(context);
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20.0, top: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: SvgPicture.asset(
                  'assets/images/profile_icons/logout-colored.svg',
                ),
              ),
              Text(AppLocalizations.of(context)!.tr('log_out'),
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        fontSize: 12,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      )),
            ],
          ),
        ),
      ),
    );
  }
}
