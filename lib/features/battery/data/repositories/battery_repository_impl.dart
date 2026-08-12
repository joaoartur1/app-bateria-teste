import '../../domain/repositories/battery_repository.dart';
import '../datasources/battery_local_datasource.dart';
import '../datasources/battery_native_datasource.dart';
import '../models/battery_model.dart';

class BatteryRepositoryImpl implements BatteryRepository {
  final BatteryNativeDataSource nativeDataSource;
  final BatteryLocalDataSource localDataSource;

  BatteryRepositoryImpl({
    required this.nativeDataSource,
    required this.localDataSource,
  });

  @override
  Future<int> getBatteryLevel() => nativeDataSource.getBatteryLevel();

  @override
  Future<List<BatteryModel>> getHistory() => localDataSource.load();

  @override
  Future saveHistory(List<BatteryModel> history) =>
      localDataSource.save(history);
}
