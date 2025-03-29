import 'package:blockchain_vaccine_project/models/pet.dart';
import 'package:blockchain_vaccine_project/pages/vaccines_list.dart';
import 'package:flutter/material.dart';
import '../components/menu.dart';
import '../data/data.dart';
import '../utils/locales.dart';
import '../widgets/dynamic_background.dart';
import 'register_vaccine.dart';

class PetsListPage extends StatelessWidget {
  const PetsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Data.getPets(),
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
                title: const Text(ListPetStrings.petsList),
              ),
              drawer: const Menu(),
              body: DynamicBackground(
                child: ListView.builder(
                  padding: const EdgeInsets.all(10.0),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    final pet = Pet.fromMap(snapshot.data[index]);
//                    final idowner = pet.id_mascota.substring(0, pet.id_mascota.indexOf('-'));
//                    final owner = Data.getOwnerById(int.parse(idowner));
                    final ownerName = 'Unknown';

                    return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        elevation: 5.0,
                        margin: const EdgeInsets.symmetric(vertical: 10.0),
                        child: ListTile(
                            contentPadding: const EdgeInsets.all(15.0),
                            title: Text(pet.name_masc,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('ID: ${pet.id_mascota}'),
                                Text('Especie: ${pet.species}'),
                                Text('Raza: ${pet.race}'),
                                Text('Color: ${pet.color}'),
                                Text('Sexo: ${pet.sex}'),
                                Text('Fecha Nacimiento: ${pet.fecha_nac}'),
//                                Text('Dueño: $ownerName'),
                                const SizedBox(height: 20),
                                Row(
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                VaccinesListPage(pet: pet),
                                          ),
                                        );
                                      },
                                      child: const Text('Ver vacunas'),
                                    ),
                                    const SizedBox(width: 10),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                RegisterVaccinePage(pet: pet),
                                          ),
                                        );
                                      },
                                      child: const Text('Registrar Vacuna'),
                                    )
                                  ],
                                )
                              ],
                            )));
                  },
                ),
              ),
            );
          }
        });
  }
}
