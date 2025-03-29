import 'package:flutter/material.dart';
import '../components/menu.dart';
import '../data/data.dart';
import '../utils/locales.dart';
import '../widgets/dynamic_background.dart';
import '../pages/doctors_list.dart';
import '../pages/vaccines_list.dart';
import '../pages/owners_list.dart';
import '../pages/pets_list.dart';

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
              FutureBuilder<List<Map<String, dynamic>>>(
                future: Data.getPets(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return const Text('Error al cargar las mascotas');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return _buildDashboardCard(
                      context,
                      icon: Icons.pets,
                      title: 'Mascotas',
                      data: '0',
                      color: Colors.blue,
                      onTapFunction: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const PetsListPage()),
                        );
                      }
                    );
                  } else {
                    return _buildDashboardCard(
                      context,
                      icon: Icons.pets,
                      title: 'Mascotas',
                      data: snapshot.data!.length.toString(),
                      color: Colors.blue,
                      onTapFunction: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const PetsListPage()),
                        );
                      }
                    );
                  }
                },
              ),
              FutureBuilder<List<Map<String, dynamic>>>(
                future: Data.getOwners(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return const Text('Error al cargar los propietarios');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return _buildDashboardCard(
                      context,
                      icon: Icons.person,
                      title: 'Propietarios',
                      data: '0',
                      color: Colors.green,
                      onTapFunction: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const OwnersListPage()),
                        );
                      }
                    );
                  } else {
                    return _buildDashboardCard(
                      context,
                      icon: Icons.person,
                      title: 'Propietarios',
                      data: snapshot.data!.length.toString(),
                      color: Colors.green,
                      onTapFunction: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const OwnersListPage()),
                        );
                      }
                    );
                  }
                },
              ),

              FutureBuilder<List<Map<String, dynamic>>>(
                future: Data.getDoctors(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return const Text('Error al cargar los doctores');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return _buildDashboardCard(
                      context,
                      icon: Icons.person_pin_outlined,
                      title: 'Doctores',
                      data: '0',
                      color: Colors.orange,
                      onTapFunction: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const DoctorsListPage()),
                        );
                      }
                    );
                  } else {
                    return _buildDashboardCard(
                        context,
                        icon: Icons.person_pin_outlined,
                        title: 'Doctores',
                        data: snapshot.data!.length.toString(),
                        color: Colors.orange,
                        onTapFunction: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const DoctorsListPage()),
                          );
                        }
                    );
                  }
                },
              ),

              FutureBuilder<List<Map<String, dynamic>>>(
                future: Data.getVaccines(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return const Text('Error al cargar las vacunas');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return _buildDashboardCard(
                      context,
                      icon: Icons.medical_services,
                      title: 'Vacunas',
                      data: '0',
                      color: Colors.red,
                        onTapFunction: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => PetsListPage()),
                          );
                        }
                    );
                  } else {
                    return _buildDashboardCard(
                      context,
                      icon: Icons.medical_services,
                      title: 'Vacunas',
                      data: snapshot.data!.length.toString(),
                      color: Colors.red,
                      onTapFunction: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PetsListPage()),
                        );
                      }
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDashboardCard(BuildContext context, {required IconData icon, required String title, required String data, required Color color, required Function() onTapFunction }) {
    return GestureDetector(
        onTap: onTapFunction,
    child: Card(
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
    )
    );
  }
}