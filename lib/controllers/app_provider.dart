import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:version/version.dart';
import '../core/service/service_locator.dart';
import '../repository/version_repository.dart';
import '../presentation/screens/other/new_version.dart' as new_version;

class AppProvider with ChangeNotifier {
  bool _canUpdate = false;
  bool? _isHMS = false;
  final String _currentVersion = "5.15.0";

  Future<void> updateProvider(bool isHMS) async {
    _isHMS = isHMS;
    if (_isHMS ?? false) {
      checkNewVersion();
    }
  }

  String get currentVersion => _currentVersion;
  bool get canUpdate => _canUpdate;

  // check if app have new version to show update page
  Future<void> checkNewVersion() async {
    final versionData =
        await sl<VersionRepository>().getLatestAppVersion(Platform.isIOS
            ? 1
            : _isHMS!
                ? 3
                : 2);
    Version currentVersion = Version.parse(_currentVersion);
    Version latestVersion =
        Version.parse(versionData.data?.value ?? _currentVersion);
    if (latestVersion > currentVersion) _canUpdate = true;
  }

  // show new version page
  void showNewVersion(BuildContext context) async {
    if (_canUpdate) {
      _canUpdate = false;
      await Future.delayed(const Duration(milliseconds: 1500), () {
        Navigator.of(
          context,
          rootNavigator: true,
        ).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    const new_version.NewVersion()),
            ModalRoute.withName('/'));
      });
    }
  }
}
