import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:version/version.dart';
import '../core/constants/constants.dart';
import '../core/service/service_locator.dart';
import '../core/utilities/dialog_helper.dart';
import '../models/promotions.dart';
import '../presentation/widgets/dialog/gift_dialog.dart';
import '../presentation/widgets/dialog/promotion_dialog.dart';
import '../repository/promotions_repository.dart';
import '../repository/version_repository.dart';
import '../presentation/screens/other/new_version.dart' as new_version;

class AppProvider with ChangeNotifier {
  final String _currentVersion = Constants.appVersion;
  bool _canUpdate = false;
  bool _canShake = false;
  bool _canShakeToday = true;
  bool _isPopPromotion = false;
  Data? _promotion;
  bool? _isHMS = false;
  String? _isoCountryCode = 'SA';
  String? _url;
  DateTime? _now;
  Promotions? promotions;
  SharedPreferences? _prefs;
  String? _lastShake;

  bool get canUpdate => _canUpdate;
  String? get url => _url;
  bool get canShake => _canShake;
  Data? get promotion => _promotion;
  bool get canShakeToday => _canShakeToday;
  bool get isPopPromotion => _isPopPromotion;

  Future<void> updateProvider(bool isHMS, String? isoCountryCode) async {
    _isHMS = isHMS;
    _isoCountryCode = isoCountryCode ?? 'SA';
    if (_isHMS ?? false) {
      _canUpdate = false;
      _checkNewVersion();
    }
  }

  Future<void> _getPromotions() async {
    promotions = await sl<PromotionsRepository>().getPromotions();
    await _initPrefs();
    _canShake =
        (promotions != null ? (promotions?.data?.last.type == "1") : false);
    if (_canShake) {
      Random random = Random();
      int randomNumber = random.nextInt(promotions!.data!.length);
      _promotion = promotions!.data![randomNumber];
      _lastShake = _prefs!.getString('lastShake');
      _now = DateTime.now();
      DateTime parsedDate = DateTime.parse(_lastShake ?? "2023-01-20 13:01:30");
      if (_now!.difference(parsedDate).inDays == 0) {
        _canShakeToday = false;
      }
    } else {
      _isPopPromotion =
          (promotions != null ? (promotions?.data?.last.type == "2") : false);
      _promotion = promotions!.data!.last;
    }
  }

  // check if app have new version to show update page
  Future<void> _checkNewVersion() async {
    print("is hms _checkNewVersion ${_isHMS!}");

    final versionData =
        await sl<VersionRepository>().getLatestAppVersion(Platform.isIOS
            ? 1
            : _isHMS!
                ? 3
                : 2);
    print('rami');
    print(versionData.data!.value.toString());
    Version currentVersion = Version.parse(_currentVersion);
    Version latestVersion =
        Version.parse(versionData.data?.value ?? _currentVersion);
    _url = _isoCountryCode == 'AE'
        ? versionData.data?.urlAe
        : versionData.data?.url;
    if (latestVersion > currentVersion) _canUpdate = true;
  }

  void showAlert(BuildContext context) async {
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
    } else if (_isPopPromotion) {
      _isPopPromotion = false;
      await Future.delayed(const Duration(milliseconds: 1500), () {
        sl<DialogHelper>().show(context, const PromotionDialog());
      });
    }
  }

  Future<void> getData({bool notify = true}) async {
    try {
      await Future.wait([
        _getPromotions(),
        _checkNewVersion(),
      ]);
    } catch (_) {}
  }

  void shake(BuildContext context) {
    if (_canShake) {
      sl<DialogHelper>().show(context, const GiftDialog());
      _prefs!.setString('lastShake', _now.toString());
      _canShake = false;
      HapticFeedback.vibrate();
    }
  }

  // init Shared Preferences
  Future<void> _initPrefs() async {
    _prefs = _prefs ?? await SharedPreferences.getInstance();
  }
}
