import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'app_localizations.dart';

class GetStrings {
  String getCurrency(String languageCode, String countryCode) {
    String currency = "";
    switch (countryCode) {
      case "SA":
        currency = languageCode == "ar" ? "ريال" : "SAR";
        break;
      case "AE":
        currency = languageCode == "ar" ? "درهم" : "AED";
        break;
      case "QA":
        currency = languageCode == "ar" ? "ريال" : "QAR";
        break;
      case "KW":
        currency = languageCode == "ar" ? "دينار" : "KWD";
        break;
      case "BH":
        currency = languageCode == "ar" ? "دينار" : "BHD";
        break;
      case "OM":
        currency = languageCode == "ar" ? "ريال" : "OMR";
        break;
    }
    return currency;
  }

  String getPaymentName(int paymentId) {
    String paymentName = "";
    switch (paymentId) {
      case 1:
        paymentName = "COD";
        break;
      case 2:
        paymentName = "Online payment";
        break;
      case 4:
        paymentName = "Tamara";
        break;
      case 7:
        paymentName = "Tabby";
        break;
    }
    return paymentName;
  }

  String getCountryKey(String countryCode) {
    String countryKey = "+966";
    switch (countryCode) {
      case "SA":
        countryKey = "+966";
        break;
      case "AE":
        countryKey = "+971";
        break;
      case "QA":
        countryKey = "+974";
        break;
      case "KW":
        countryKey = "+965";
        break;
      case "BH":
        countryKey = "+973";
        break;
      case "OM":
        countryKey = "+968";
        break;
    }
    return countryKey;
  }

  String locationDescription(Placemark place) {
    String description = "";
    if (place.postalCode!.length > 1) description += place.postalCode!;
    if (place.subLocality!.length > 1) {
      description += ", ${place.subLocality!}";
    } else if (place.locality!.length > 1) {
      description += ", ${place.locality!}";
    } else if (place.administrativeArea!.length > 1) {
      description += ", ${place.administrativeArea!}";
    } else if (place.subAdministrativeArea!.length > 1) {
      description += ", ${place.subAdministrativeArea!}";
    }
    if (place.street!.length > 1 && !Platform.isAndroid) {
      description += ", ${place.street!}";
    } else if (place.thoroughfare!.length > 1) {
      description += ", ${place.thoroughfare!}";
    } else if (place.name!.length > 1) {
      description += ", ${place.name!}";
    }
    if (place.street!.length > 1 &&
        description.length < 10 &&
        Platform.isAndroid) description += ", ${place.street!}";
    return description;
  }

  String currentLocation(BuildContext context,
      String? currentLocationDescription, String? currentLocationDescription2) {
    return AppLocalizations.of(context)!.locale!.languageCode == "ar"
        ? (currentLocationDescription ??
            AppLocalizations.of(context)!.tr('current_location'))
        : (currentLocationDescription2 ??
            AppLocalizations.of(context)!.tr('current_location'));
  }

  String getGender(BuildContext context, int value) {
    return value == 0
        ? AppLocalizations.of(context)!.tr('maleString')
        : value == 1
            ? AppLocalizations.of(context)!.tr('femaleString')
            : "";
  }
}
