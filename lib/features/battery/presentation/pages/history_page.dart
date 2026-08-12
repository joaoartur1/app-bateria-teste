import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/battery_controller.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<BatteryController>();

    if (controller.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (controller.history.isEmpty) {
      return const Center(
        child: Text(
          'Nenhum histórico encontrado.',
          style: TextStyle(fontSize: 18),
        ),
      );
    }

    return ListView.builder(
      itemCount: controller.history.length,
      itemBuilder: (context, index) {
        final record = controller.history[index];
        // Formatação simples de data/hora
        final formattedDate =
            "${record.time.day}/${record.time.month}/${record.time.year} às ${record.time.hour}:${record.time.minute.toString().padLeft(2, '0')}";

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.blue,
              child: Icon(Icons.battery_std, color: Colors.white),
            ),
            title: Text(
              '${record.level}% de bateria',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(formattedDate),
          ),
        );
      },
    );
  }
}
