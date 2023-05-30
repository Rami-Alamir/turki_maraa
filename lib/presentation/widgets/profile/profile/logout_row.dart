import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../dialog/confirm_dialog.dart';
import '../../../../controllers/auth.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/fixed_assets.dart';
import '../../../../core/service/service_locator.dart';
import '../../../../core/utilities/app_localizations.dart';
import '../../../../core/utilities/dialog_helper.dart';

class LogOutRow extends StatelessWidget {
  const LogOutRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Auth auth = Provider.of<Auth>(context);

    return Visibility(
      visible: auth.isAuth,
      child: InkWell(
        onTap: () {
          sl<DialogHelper>().show(
              context,
              ConfirmDialog(
                confirmAction: () async {
                  await auth.logOut(context);
                },
                message: 'Are_you_sure_you_want_to_log_out',
                title: 'log_out',
                icon: FixedAssets.logout,
              ));
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
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      color: AppColors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }
}
