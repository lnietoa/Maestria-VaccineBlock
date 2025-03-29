import 'package:blockchain_vaccine_project/models/vaccine.dart';
import 'package:flutter/material.dart';
import '../models/pet.dart';
import '../data/data.dart';

class VaccinesListPage extends StatelessWidget {
  final Pet pet;

  const VaccinesListPage({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
//    final vaccines = Data.getVaccinesForPet(pet.id_mascota);
    return FutureBuilder(
        future: Data.getVaccinesForPet(pet.id_mascota),
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
                  style: Theme.of(context).textTheme.headlineMedium,
                )));
          } else {
            return Scaffold(
              appBar: AppBar(
                title: Text('Vacunas de ${pet.name_masc}'),
              ),
              body: snapshot.data.isEmpty
                  ? Center(
                      child:
                          Text('No hay vacunas registradas para esta mascota'),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(10.0),
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        final vaccine = Vaccine.fromMap(snapshot.data[index]);
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          elevation: 5.0,
                          margin: const EdgeInsets.symmetric(vertical: 10.0),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(15.0),
                            title: Text(vaccine.id_vacuna,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Vacuna: ${vaccine.name_vac}'),
                                Text('Fecha: ${vaccine.date_vac}'),
                                Text('Laboratorio: ${vaccine.laboratorio}'),
                                Text('Veterinario: ${vaccine.id_doctor}'),
                                Text('Sede: ${vaccine.id_sede}'),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            );
          }
        });
  }
}
