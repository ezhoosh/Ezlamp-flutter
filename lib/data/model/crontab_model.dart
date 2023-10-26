class CrontabModel {
  String minute;
  String hour;
  String dayOfWeek;
  String dayOfMonth;
  String monthOfYear;

  CrontabModel({
    required this.minute,
    required this.hour,
    required this.dayOfWeek,
    required this.dayOfMonth,
    required this.monthOfYear,
  });

  factory CrontabModel.fromJson(Map<String, dynamic> json) => CrontabModel(
        minute: json["minute"],
        hour: json["hour"],
        dayOfWeek: json["day_of_week"],
        dayOfMonth: json["day_of_month"],
        monthOfYear: json["month_of_year"],
      );

  Map<String, dynamic> toJson() => {
        "minute": minute,
        "hour": hour,
        "day_of_week": dayOfWeek,
        "day_of_month": dayOfMonth,
        "month_of_year": monthOfYear,
      };
}
