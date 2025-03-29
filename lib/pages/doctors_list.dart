
// File: lib/pages/doctors_list.dart

import 'package:flutter/material.dart';
import '../components/menu.dart';
import '../data/data.dart';
import '../models/doctor.dart';
import '../widgets/dynamic_background.dart';

class DoctorsListPage extends StatelessWidget {
  const DoctorsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Data.getDoctors(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
                color: Colors.white,
                child: const LinearProgressIndicator(
                    backgroundColor: Colors.black));
          } else if (snapshot.hasError) {
            return Container(
                color: Colors.white,
                child: Center(
                    child: Text(
                      "Lo sentimos. Inténtelo de nuevo.",
                      style: Theme
                          .of(context)
                          .textTheme
                          .headlineMedium,
                    )));
          } else {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Lista de Doctores'),
              ),
              drawer: const Menu(),
              body: DynamicBackground(
                child: snapshot.hasError
                    ? const Center(
                  child: Text('No hay doctores registrados'),
                )
                    : ListView.builder(
                  padding: const EdgeInsets.all(10.0),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    final doctor = Doctor.fromMap(snapshot.data[index]);
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 5.0,
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(15.0),
                        title: Text(doctor.name, style: const TextStyle(
                            fontWeight: FontWeight.bold)),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Identificacion: ${doctor.id_doctor.toString()}'),
                            Text('Num_TP: ${doctor.num_tp.toString()}'),
                            Text('Contacto: ${doctor.contact.toString()}'),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          }
        });
  }
}
