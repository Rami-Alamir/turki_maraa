import '../models/app_version.dart';
import '../networking/api_base_helper.dart';

class VersionRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<AppVersion> getLatestAppVersion(int id) async {
    final response = await _helper.get("setting-app/version/$id");
    AppVersion? appVersion;
    try {
      appVersion = AppVersion.fromJson(response);
    } catch (e) {
      print(e.toString());
    }
    return appVersion!;
  }
}
