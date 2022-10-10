import 'package:google_maps_flutter/google_maps_flutter.dart' as gms;

class LocalsValues {
  String getCountryCode(String isoCountryCode) {
    switch (isoCountryCode) {
      case "AE":
        return "AE";
      default:
        return "SA";
    }
  }

  gms.LatLng getGMSLatLng(String isoCountryCode) {
    switch (isoCountryCode) {
      case "AE":
        return const gms.LatLng(25.26197948433779, 55.39862529171184);
      default:
        return const gms.LatLng(24.806256, 46.650722);
    }
  }
}
