class BatteryInfo {
  final int level;
  final String status;

  BatteryInfo({required this.level, required this.status});

  @override
  String toString() => 'BatteryInfo(level: $level, status: $status)';
}
