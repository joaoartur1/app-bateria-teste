import '../../data/models/battery_model.dart';

abstract class BatteryRepository {
  Future<int> getBatteryLevel();
  Future<List<BatteryModel>> getHistory();
  Future saveHistory(List<BatteryModel> history);
}
