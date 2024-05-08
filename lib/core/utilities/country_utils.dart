import '../../models/country.dart';

class CountryUtils {
  CountryUtils._();

  static Country getCountryByCountryCode(String code) {
    try {
      return countries.firstWhere((country) =>
          country.isoCountryCode.toLowerCase() == code.toLowerCase());
    } catch (_) {
      return countries[0];
    }
  }

  static final List<Country> countries = [
    Country(
      nameAr: 'المملكة العربية السعودية',
      nameEn: 'Saudi Arabia',
      flag: "🇸🇦",
      isoCountryCode: 'SA',
      dialCode: '+966',
    ),
    Country(
      nameAr: 'الإمارات العربية المتحدة',
      nameEn: "United Arab Emirates",
      flag: "🇦🇪",
      isoCountryCode: 'AE',
      dialCode: '+971',
    ),
    // Country(
    //   nameAr: 'قطر',
    //   nameEn: "Qatar",
    //   flag: "🇶🇦",
    //   isoCountryCode: 'QA',
    //   dialCode: '+974',
    // ),
    // Country(
    //   nameAr: 'الكويت',
    //   nameEn: "Kuwait",
    //   flag: "🇰🇼",
    //   isoCountryCode: 'KW',
    //   dialCode: '+965',
    // ),
    // Country(
    //   nameAr: 'مصر',
    //   nameEn: "Egypt",
    //   flag: "🇪🇬",
    //   isoCountryCode: 'EG',
    //   dialCode: '+20',
    // ),
    // Country(
    //   nameAr: 'البحرين',
    //   nameEn: "Bahrain",
    //   flag: "🇧🇭",
    //   isoCountryCode: 'BH',
    //   dialCode: '+973',
    // ),
  ];
}
