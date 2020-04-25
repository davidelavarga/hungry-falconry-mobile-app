class ScheduleModel {
  final int id;
  final String timestamp;
  final int feeder;
  final bool done;

  const ScheduleModel({this.id, this.timestamp, this.feeder, this.done});

  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    return ScheduleModel(
        id: json['id'],
        timestamp: json['timestamp'],
        feeder: json['feeder'],
        done: json['done']);
  }
}
