class LocationData {
  int? id;
  double? latitude;
  double? longitude;
  String? isoCountryCode;
  String? selectedLocationDescription;

  LocationData(
      {this.latitude,
      this.id,
      this.longitude,
      this.isoCountryCode,
      this.selectedLocationDescription});

  LocationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    isoCountryCode = json['isoCountryCode'];
    selectedLocationDescription = json['selectedLocationDescription'];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'latitude': latitude,
        'longitude': longitude,
        'isoCountryCode': isoCountryCode,
        'selectedLocationDescription': selectedLocationDescription,
      };
}
