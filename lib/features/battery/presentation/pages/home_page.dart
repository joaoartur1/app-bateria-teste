import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/battery_controller.dart';
import 'history_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<BatteryController>();

    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _currentIndex,
          children: [_buildDashboard(context, controller), const HistoryPage()],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.battery_5_bar_outlined),
            selectedIcon: Icon(Icons.battery_5_bar),
            label: 'Bateria',
          ),
          NavigationDestination(
            icon: Icon(Icons.history_outlined),
            selectedIcon: Icon(Icons.history),
            label: 'Histórico',
          ),
        ],
      ),
    );
  }

  Widget _buildDashboard(BuildContext context, BatteryController controller) {
    final latest = controller.history.isNotEmpty
        ? controller.history.first
        : null;

    final level = latest?.level ?? 0;

    return RefreshIndicator(
      onRefresh: controller.initLoad,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
        children: [
          _buildHeader(),
          const SizedBox(height: 24),
          _buildBatteryCard(controller, level),
          const SizedBox(height: 16),
          _buildStatsCard(controller),
          const SizedBox(height: 24),
          _buildActionButton(controller),
          if (controller.errorMessage != null) ...[
            const SizedBox(height: 16),
            _buildError(controller.errorMessage!),
          ],
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: const Color(0xFFEFF6FF),
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Icon(
            Icons.battery_charging_full,
            color: Color(0xFF2563EB),
            size: 26,
          ),
        ),
        const SizedBox(width: 14),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Battery Monitor',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                ),
              ),
              SizedBox(height: 3),
              Text(
                'Monitoramento da bateria',
                style: TextStyle(color: Color(0xFF64748B), fontSize: 14),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBatteryCard(BatteryController controller, int level) {
    final progress = (level / 100).clamp(0.0, 1.0);

    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Nível atual',
              style: TextStyle(
                color: Color(0xFF64748B),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 28),
          SizedBox(
            width: 190,
            height: 190,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 190,
                  height: 190,
                  child: CircularProgressIndicator(
                    value: progress,
                    strokeWidth: 13,
                    backgroundColor: const Color(0xFFE2E8F0),
                    strokeCap: StrokeCap.round,
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '$level%',
                      style: const TextStyle(
                        fontSize: 46,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -2,
                      ),
                    ),
                    Text(
                      _batteryStatus(level),
                      style: const TextStyle(
                        color: Color(0xFF64748B),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),
          if (controller.isLoading)
            const SizedBox(
              height: 52,
              child: Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }

  Widget _buildStatsCard(BatteryController controller) {
    final latest = controller.history.isNotEmpty
        ? controller.history.first
        : null;

    final time = latest == null
        ? '--:--'
        : '${latest.time.hour.toString().padLeft(2, '0')}:'
              '${latest.time.minute.toString().padLeft(2, '0')}';

    return Row(
      children: [
        Expanded(
          child: _statCard(
            icon: Icons.history,
            title: 'Consultas',
            value: '${controller.history.length}',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _statCard(
            icon: Icons.schedule,
            title: 'Última leitura',
            value: time,
          ),
        ),
      ],
    );
  }

  Widget _statCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xFF2563EB), size: 22),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF64748B),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(BatteryController controller) {
    return SizedBox(
      height: 56,
      width: double.infinity,
      child: FilledButton.icon(
        onPressed: controller.isLoading ? null : controller.fetchAndSaveBattery,
        icon: controller.isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : const Icon(Icons.refresh),
        label: Text(
          controller.isLoading ? 'Consultando...' : 'Consultar bateria',
        ),
        style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  Widget _buildError(String message) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFEF2F2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(Icons.error_outline, color: Color(0xFFDC2626)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(color: Color(0xFF991B1B), fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  String _batteryStatus(int level) {
    if (level >= 80) return 'Excelente';
    if (level >= 50) return 'Boa';
    if (level >= 20) return 'Moderada';
    return 'Baixa';
  }
}
