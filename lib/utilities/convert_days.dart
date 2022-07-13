class ConvertDays {
  static convertDay(String day) {
    switch (day) {
      case "07-09":
        return 'first_day';
      case "07-10":
        return 'second_day';
      case "07-11":
        return 'third_day';
      default:
        return 'fourth_day';
    }
  }
}
