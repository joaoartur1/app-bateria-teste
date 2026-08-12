import 'package:shared_preferences/shared_preferences.dart';
import '../models/battery_model.dart';

class BatteryLocalDataSource {
  static const String _key = 'battery_history';

  Future save(List<BatteryModel> records) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = records.map((r) => r.toJson()).toList();
    await prefs.setStringList(_key, jsonList);
  }

  Future<List<BatteryModel>> load() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = prefs.getStringList(_key);
    if (jsonList == null) return [];
    return jsonList.map((json) => BatteryModel.fromJson(json)).toList();
  }
}
