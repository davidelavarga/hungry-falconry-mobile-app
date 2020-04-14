class FeederModel {
  final int id;
  final String nameByUser;
  final String macAddress;
  final int maxPortions;
  final int currentPortions;

  const FeederModel(
      {this.id,
      this.maxPortions,
      this.currentPortions,
      this.nameByUser,
      this.macAddress});

  factory FeederModel.fromJson(Map<String, dynamic> json) {
    return FeederModel(
        id: json['id'],
        nameByUser: json['name_by_user'],
        macAddress: json['mac_address'],
        maxPortions: json['max_portions'],
        currentPortions: json['current_portions']);
  }
}
