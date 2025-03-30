import 'package:flutter/material.dart';
import '../data/data.dart';
import '../utils/constants.dart';
import '../utils/locales.dart';
import '../pages/register_owner.dart';
import '../pages/owners_list.dart';
import '../pages/login.dart';
import '../pages/dashboard.dart';
import '../pages/pets_list.dart';
import '../pages/register_doctor.dart';
import '../pages/doctors_list.dart'; // Import the DoctorsListPage

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: AppConstants.drawerHeaderColor,
            ),
            child: Text(
              MenuStrings.menuTitle,
              style: TextStyle(
                color: AppConstants.drawerHeaderTextColor,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home, color: AppConstants.iconColor),
            title: const Text(MenuStrings.home, style: TextStyle(color: AppConstants.textColor)),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const DashboardPage()));
            },
          ),
          ExpansionTile(
            leading: const Icon(Icons.add, color: AppConstants.iconColor),
            title: const Text(MenuStrings.register, style: TextStyle(color: AppConstants.textColor)),
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.person_add, color: AppConstants.iconColor),
                title: const Text(MenuStrings.registerOwner, style: TextStyle(color: AppConstants.textColor)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RegisterOwnerPage()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.person_add, color: AppConstants.iconColor),
                title: const Text(MenuStrings.registerDoctor, style: TextStyle(color: AppConstants.textColor)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterDoctorPage()),
                  );
                },
              ),
            ],
          ),
          ExpansionTile(
            leading: const Icon(Icons.view_list, color: AppConstants.iconColor),
            title: const Text(MenuStrings.view, style: TextStyle(color: AppConstants.textColor)),
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.people, color: AppConstants.iconColor),
                title: const Text(MenuStrings.ownersList, style: TextStyle(color: AppConstants.textColor)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const OwnersListPage()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.pets, color: AppConstants.iconColor),
                title: const Text(MenuStrings.petsList, style: TextStyle(color: AppConstants.textColor)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PetsListPage()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.medical_services, color: AppConstants.iconColor),
                title: const Text('Lista de Doctores', style: TextStyle(color: AppConstants.textColor)), // Add this ListTile
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const DoctorsListPage()),
                  );
                },
              ),
            ],
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: AppConstants.iconColor),
            title: const Text(MenuStrings.logout, style: TextStyle(color: AppConstants.textColor)),
            onTap: () async {
              await Data.desconectar();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
