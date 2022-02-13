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
}
