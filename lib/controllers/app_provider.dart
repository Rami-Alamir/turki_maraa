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
import '../repository/promotions_repository.dart';
import '../repository/version_repository.dart';

class AppProvider with ChangeNotifier {
  final String _currentVersion = Constants.appVersion;
  bool _canUpdate = false;
  bool _canShake = false;
  bool _canShakeToday = true;
  bool _isPopPromotion = false;
  Data? _promotion;
  bool? _isHMS = false;
  String? _isoCountryCode = 'SA';
  String? _isoCountryCode2;
  String? _url;
  DateTime? _now;
  Promotions? promotions;
  SharedPreferences? _prefs;
  String? _lastShake;
  bool _showEidMessage = true;
  bool get canUpdate => _canUpdate;
  String? get url => _url;
  bool get canShake => _canShake;
  Data? get promotion => _promotion;
  bool get canShakeToday => _canShakeToday;
  bool get isPopPromotion => _isPopPromotion;

  Future<void> updateProvider(bool isHMS, String? isoCountryCode) async {
    _isHMS = isHMS;
    _isoCountryCode = isoCountryCode ?? 'SA';
    _isoCountryCode2 = isoCountryCode;
    if (_isHMS ?? false) {
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
    try {
      final versionData =
          await VersionRepository().getLatestAppVersion(Platform.isIOS
              ? 1
              : _isHMS!
                  ? 3
                  : 2);
      Version currentVersion = Version.parse(_currentVersion);
      Version latestVersion =
          Version.parse(versionData?.data?.value ?? _currentVersion);
      _url = _isoCountryCode == 'AE'
          ? versionData?.data?.urlAe
          : versionData?.data?.url;
      if (latestVersion > currentVersion) _canUpdate = true;
    } catch (_) {}
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

  Future<bool> showEidMessage() async {
    try {
      if (_isoCountryCode2 == 'SA') {
        final versionData = await VersionRepository().getLatestAppVersion(100);
        if (_showEidMessage && versionData != null) {
          _showEidMessage = false;
          return true;
        }
      }
    } catch (_) {}
    return false;
  }

  // init Shared Preferences
  Future<void> _initPrefs() async {
    _prefs = _prefs ?? await SharedPreferences.getInstance();
  }
}
