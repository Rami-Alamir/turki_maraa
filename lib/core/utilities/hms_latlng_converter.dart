import 'package:huawei_location/huawei_location.dart';
import 'package:huawei_map/huawei_map.dart' as hms;
import 'package:google_maps_flutter/google_maps_flutter.dart' as gms;

class HMSLatLngConverter {
  gms.LatLng convertToGMSLatLng(HWLocation hwlocation) {
    return gms.LatLng(hwlocation.latitude!, hwlocation.longitude!);
  }

  gms.LatLng convertToGMSLatLng2(hms.LatLng latLng) {
    return gms.LatLng(latLng.lat, latLng.lng);
  }

  hms.LatLng convertToHMSLatLng(gms.LatLng latLng) {
    return hms.LatLng(latLng.latitude, latLng.longitude);
  }
}
