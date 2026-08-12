import 'package:flutter/material.dart';
import '../../domain/repositories/battery_repository.dart';
import '../../data/models/battery_model.dart';

class BatteryController extends ChangeNotifier {
  final BatteryRepository repository;

  List<BatteryModel> _history = [];
  List<BatteryModel> get history => _history;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  BatteryController(this.repository);

  void init() {
    initLoad();
  }

  Future<void> initLoad() async {
    _isLoading = true;
    notifyListeners();

    try {
      _history = await repository.getHistory();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = 'Erro ao carregar histórico: ${e.toString()}';
      _history = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchAndSaveBattery() async {
    _errorMessage = null;
    notifyListeners();

    try {
      final level = await repository.getBatteryLevel();
      final newRecord = BatteryModel(level: level, time: DateTime.now());

      _history.insert(0, newRecord);
      await repository.saveHistory(_history);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      notifyListeners();
    }
  }
}
