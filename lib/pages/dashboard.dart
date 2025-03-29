import 'package:flutter/material.dart';
import '../components/menu.dart';
import '../utils/locales.dart';
import '../widgets/dynamic_background.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(DashboardStrings.dashboard),
      ),
      drawer: const Menu(),
      body: DynamicBackground(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            children: <Widget>[
              _buildDashboardCard(
                context,
                icon: Icons.pets,
                title: 'Mascotas',
                data: '150',
                color: Colors.blue,
              ),
              _buildDashboardCard(
                context,
                icon: Icons.person,
                title: 'Dueños',
                data: '75',
                color: Colors.green,
              ),
              _buildDashboardCard(
                context,
                icon: Icons.event,
                title: 'Doctores',
                data: '10',
                color: Colors.orange,
              ),
              _buildDashboardCard(
                context,
                icon: Icons.medical_services,
                title: 'Vacunas',
                data: '5',
                color: Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDashboardCard(BuildContext context, {required IconData icon, required String title, required String data, required Color color}) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon, size: 40.0, color: color),
            const SizedBox(height: 10.0),
            Text(
              title,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              data,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}