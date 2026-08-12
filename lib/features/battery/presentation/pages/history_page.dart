import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/battery_controller.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<BatteryController>();

    return Column(
      children: [
        _buildHeader(),
        Expanded(child: _buildContent(controller)),
      ],
    );
  }

  Widget _buildHeader() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(20, 24, 20, 20),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Histórico',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.7,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Suas últimas leituras de bateria',
                style: TextStyle(color: Color(0xFF64748B), fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BatteryController controller) {
    if (controller.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (controller.history.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
      itemCount: controller.history.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final record = controller.history[index];

        return _buildHistoryCard(record.level, record.time);
      },
    );
  }

  Widget _buildHistoryCard(int level, DateTime time) {
    final formattedDate =
        '${time.day.toString().padLeft(2, '0')}/'
        '${time.month.toString().padLeft(2, '0')}/'
        '${time.year}';

    final formattedTime =
        '${time.hour.toString().padLeft(2, '0')}:'
        '${time.minute.toString().padLeft(2, '0')}';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          _batteryIcon(level),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$level% de bateria',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '$formattedDate • $formattedTime',
                  style: const TextStyle(
                    color: Color(0xFF64748B),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '$level%',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: Color(0xFF2563EB),
            ),
          ),
        ],
      ),
    );
  }

  Widget _batteryIcon(int level) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FF),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Icon(
        level >= 80
            ? Icons.battery_full
            : level >= 50
            ? Icons.battery_5_bar
            : level >= 20
            ? Icons.battery_3_bar
            : Icons.battery_1_bar,
        color: const Color(0xFF2563EB),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: const Color(0xFFEFF6FF),
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Icon(
                Icons.history,
                size: 40,
                color: Color(0xFF2563EB),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Nenhum histórico',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            const Text(
              'Faça uma consulta de bateria para começar a registrar suas leituras.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xFF64748B), height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
