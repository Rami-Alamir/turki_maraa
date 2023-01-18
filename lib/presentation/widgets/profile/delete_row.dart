import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controllers/auth.dart';
import '../../../core/constants/fixed_assets.dart';
import '../../../core/service/service_locator.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/dialog_helper.dart';
import '../../../core/utilities/show_snack_bar.dart';
import '../dialog/confirm_dialog.dart';
import '../dialog/indicator_dialog.dart';

class DeleteRow extends StatefulWidget {
  const DeleteRow({Key? key}) : super(key: key);

  @override
  State<DeleteRow> createState() => _DeleteRowState();
}

class _DeleteRowState extends State<DeleteRow> {
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: Platform.isIOS || Platform.isMacOS,
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          final Auth auth = Provider.of<Auth>(context, listen: false);
          sl<DialogHelper>().show(
              context,
              ConfirmDialog(
                confirmAction: () async {
                  sl<DialogHelper>().show(context, const IndicatorDialog());
                  bool status = await auth.deleteAccount();
                  if (!mounted) return;
                  Navigator.of(context, rootNavigator: true).pop();
                  if (status) {
                    await auth.logOut(context);
                    if (!mounted) return;
                    Navigator.of(context).pop();
                  } else {
                    sl<ShowSnackBar>().show(context, "unexpected_error");
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
                  style: Theme.of(context).textTheme.subtitle2!.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      )),
            ],
          ),
        ),
      ),
    );
  }
}
