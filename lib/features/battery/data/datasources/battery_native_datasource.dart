import 'package:flutter/services.dart';
import '../../../../core/errors/exceptions.dart';

class BatteryNativeDataSource {
  static const platform = MethodChannel('samples.flutter.dev/battery');

  Future<int> getBatteryLevel() async {
    try {
      final level = await platform.invokeMethod<int>('getBatteryLevel');
      if (level == null) {
        throw NativeException('Erro nativo: valor de bateria inválido.');
      }
      return level;
    } on PlatformException catch (e) {
      throw NativeException("Erro nativo: ${e.message}");
    } catch (e) {
      throw NativeException("Erro de canal nativo.");
    }
  }
}
