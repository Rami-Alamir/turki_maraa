import 'package:google_maps_flutter/google_maps_flutter.dart' as GMS;
import 'package:huawei_location/location/hwlocation.dart';
import 'package:huawei_map/map.dart' as HMS;

class HMSLatLngConverter {
  GMS.LatLng convertToGMSLatLng(HWLocation _hwlocation) {
    return GMS.LatLng(_hwlocation.latitude!, _hwlocation.longitude!);
  }

  GMS.LatLng convertToGMSLatLng2(HMS.LatLng latLng) {
    return GMS.LatLng(latLng.lat, latLng.lng);
  }

  HMS.LatLng convertToHMSLatLng(GMS.LatLng latLng) {
    return HMS.LatLng(latLng.latitude, latLng.longitude);
  }
}
