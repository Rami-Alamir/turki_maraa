import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../dialog/confirm_dialog.dart';
import '../../dialog/indicator_dialog.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../controllers/auth.dart';
import '../../../../core/constants/fixed_assets.dart';
import '../../../../core/service/service_locator.dart';
import '../../../../core/utilities/app_localizations.dart';
import '../../../../core/utilities/dialog_helper.dart';
import '../../../../core/utilities/show_snack_bar.dart';

class DeleteRow extends StatelessWidget {
  const DeleteRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: Platform.isIOS || Platform.isMacOS,
      child: InkWell(
        onTap: () {
          final Auth auth = Provider.of<Auth>(context, listen: false);
          sl<DialogHelper>().show(
              context,
              ConfirmDialog(
                confirmAction: () async {
                  sl<DialogHelper>().show(context, const IndicatorDialog());
                  bool status = await auth.deleteAccount();
                  if (context.mounted) {
                    Navigator.of(context, rootNavigator: true).pop();
                    if (status) {
                      await auth.logOut(context);
                      if (context.mounted) Navigator.of(context).pop();
                    } else {
                      sl<ShowSnackBar>().show(context, "unexpected_error");
                    }
                  }
                },
                message: 'are_you_sure_you_want_to_delete_the_account',
                title: 'delete_account',
                icon: FixedAssets.deleteAccount,
              ));
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20.0, top: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(AppLocalizations.of(context)!.tr('delete_account'),
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontSize: 12,
                        color: AppColors.red,
                        fontWeight: FontWeight.bold,
                      )),
            ],
          ),
        ),
      ),
    );
  }
}
