import '../models/app_version.dart';
import '../core/service/networking/api_base_helper.dart';
import '../core/service/service_locator.dart';

class VersionRepository {
  final ApiBaseHelper _helper = sl<ApiBaseHelper>();

  Future<AppVersion> getLatestAppVersion(int id) async {
    final response = await _helper.get("setting-app/version/$id");
    AppVersion? appVersion;
    try {
      appVersion = AppVersion.fromJson(response);
    } catch (_) {}
    return appVersion!;
  }
}
