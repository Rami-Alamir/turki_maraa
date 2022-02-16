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
}
