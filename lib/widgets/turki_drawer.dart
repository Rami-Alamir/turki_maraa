import 'package:flutter/material.dart';
import 'package:new_turki/provider/app_language.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/ra7_icons.dart';
import 'package:provider/provider.dart';

class TurkiDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _appLanguage = Provider.of<AppLanguage>(context);
    return Drawer(
      child: Container(
        color: Theme.of(context).backgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text('Ahmed Ibrahim'),
                  accountEmail: Text(''),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                  ),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Theme.of(context).backgroundColor,
                    child: Text(
                      'A I',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                ),
                _createDrawerItem(
                  context: context,
                  icon: RA7ICONS.home,
                  onTap: () => Navigator.of(context).pop(),
                  text: 'الرئيسية',
                ),
                _createDrawerItem(
                  context: context,
                  icon: RA7ICONS.menu,
                  onTap: () {
                    // _makePhoneCall();
                  },
                  text: 'support',
                ),
                _createDrawerItem(
                  context: context,
                  icon: RA7ICONS.menu__1_,
                  onTap: () {
                    _appLanguage.changeLanguage();
                  },
                  text: 'language',
                ),
                _createDrawerItem(
                  context: context,
                  icon: RA7ICONS.notification,
                  onTap: () {
                    // ShowConfirmDialog().logoutDialog(context);
                  },
                  text: 'sign_out',
                ),
                _createDrawerItem(
                  context: context,
                  icon: RA7ICONS.box,
                  onTap: () {
                    // ShowConfirmDialog().logoutDialog(context);
                  },
                  text: 'sign_out',
                ),
                _createDrawerItem(
                  context: context,
                  icon: RA7ICONS.heart,
                  onTap: () {
                    // ShowConfirmDialog().logoutDialog(context);
                  },
                  text: 'sign_out',
                ),
                _createDrawerItem(
                  context: context,
                  icon: RA7ICONS.heart__1_,
                  onTap: () {
                    // ShowConfirmDialog().logoutDialog(context);
                  },
                  text: 'sign_out',
                ),
                _createDrawerItem(
                  context: context,
                  icon: RA7ICONS.supplies,
                  onTap: () {
                    // ShowConfirmDialog().logoutDialog(context);
                  },
                  text: 'sign_out',
                ),
                _createDrawerItem(
                  context: context,
                  icon: RA7ICONS.box__2_,
                  onTap: () {
                    // ShowConfirmDialog().logoutDialog(context);
                  },
                  text: 'sign_out',
                ),
                _createDrawerItem(
                  context: context,
                  icon: RA7ICONS.share,
                  onTap: () {
                    // ShowConfirmDialog().logoutDialog(context);
                  },
                  text: 'sign_out',
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(60.0),
                  child: Text('V3.0.0'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _createDrawerItem(
      {required IconData icon,
      required BuildContext context,
      required String text,
      required GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(
            icon,
            size: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(text,
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    ?.copyWith(color: Colors.black, fontSize: 14)),
          )
        ],
      ),
      onTap: onTap,
    );
  }

  // Future<void> _makePhoneCall() async {
  //   if (await canLaunch('tel:+966118280980')) {
  //     await launch('tel:+966118280980');
  //   } else {
  //     throw 'Could not launch tel:+966118280980';
  //   }
  // }
}
