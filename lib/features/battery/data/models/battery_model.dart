import 'dart:convert';

class BatteryModel {
  final int level;
  final DateTime time;

  // As chaves {} e o "required" são obrigatórios para os nomes aparecerem
  BatteryModel({required this.level, required this.time});

  Map toMap() => {'level': level, 'time': time.toIso8601String()};

  factory BatteryModel.fromMap(Map map) =>
      BatteryModel(level: map['level'], time: DateTime.parse(map['time']));

  String toJson() => json.encode(toMap());
  factory BatteryModel.fromJson(String source) =>
      BatteryModel.fromMap(json.decode(source));
}
