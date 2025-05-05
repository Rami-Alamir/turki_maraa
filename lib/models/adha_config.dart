class AdhaConfig {
  int? categoryId;
  int? cutId;
  List<String>? dates;
  List<bool>? cutStatus;

  AdhaConfig({
    this.categoryId,
    this.cutId,
    this.dates,
    this.cutStatus,
  });

  AdhaConfig.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    cutId = json['cut_id'];
    dates = json['dates'].cast<String>();
    cutStatus = json['cut_status'].cast<bool>();
  }
}
