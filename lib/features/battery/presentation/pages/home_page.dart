import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/battery_controller.dart';
import 'history_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<BatteryController>();

    final pages = [_buildBateriaPage(controller), const HistoryPage()];

    return Scaffold(
      appBar: AppBar(title: const Text('App Bateria'), centerTitle: true),
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.battery_charging_full),
            label: 'Bateria',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Histórico',
          ),
        ],
      ),
    );
  }

  Widget _buildBateriaPage(BatteryController controller) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () => controller.fetchAndSaveBattery(),
            child: const Text('Consultar Bateria'),
          ),
          const SizedBox(height: 20),
          if (controller.history.isNotEmpty)
            Text('Nível: ${controller.history.first.level}%'),
        ],
      ),
    );
  }
}
