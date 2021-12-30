class ConvertPhone {
  static String getPhone(String key, String phone) {
    String newPhone = key;
    newPhone += phone.length == 10
        ? convertPhone(phone).substring(1, 10)
        : convertPhone(phone);
    return newPhone;
  }

  static String convertPhone(String phone) {
    String newPhone = '';
    for (int i = 0; i < phone.length; i++) {
      newPhone += convertNumber(phone[i]);
    }
    return newPhone;
  }

  static String convertNumber(String number) {
    switch (number) {
      case '0':
      case '٠':
        return '0';
      case '1':
      case '١':
        return '1';
      case '2':
      case '٢':
        return '2';
      case '3':
      case '٣':
        return '3';
      case '4':
      case '٤':
        return '4';
      case '5':
      case '٥':
        return '5';
      case '6':
      case '٦':
        return '6';
      case '7':
      case '٧':
        return '7';
      case '8':
      case '٨':
        return '8';
      case '9':
      case '٩':
        return '9';
      default:
        return number;
    }
  }
}
