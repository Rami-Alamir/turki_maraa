import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../controllers/auth.dart';
import '../../../core/constants/fixed_assets.dart';
import '../../../core/utilities/app_localizations.dart';

class LogOutRow extends StatelessWidget {
  final bool isAuth;

  const LogOutRow({Key? key, required this.isAuth}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isAuth,
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          final Auth auth = Provider.of<Auth>(context, listen: false);
          auth.logOut(context);
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20.0, top: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: SvgPicture.asset(
                  FixedAssets.logout,
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
