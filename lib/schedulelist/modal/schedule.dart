class ScheduleModel {
  final String timestamp;
  final int feeder;
  final bool done;

  const ScheduleModel({this.timestamp, this.feeder, this.done});

  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    return ScheduleModel(
        timestamp: json['timestamp'],
        feeder: json['feeder'],
        done: json['done']);
  }
}
