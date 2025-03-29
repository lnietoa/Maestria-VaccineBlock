import 'package:blockchain_vaccine_project/data/VacunaBlock.dart';
import 'package:blockchain_vaccine_project/models/vaccine.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/pet.dart';
import '../data/data.dart';
import '../widgets/dynamic_background.dart';

class VaccinesListPage extends StatefulWidget {
  final Pet pet;

  const VaccinesListPage({super.key, required this.pet});

  @override
  _VaccinesListPageState createState() => _VaccinesListPageState();
}

class _VaccinesListPageState extends State<VaccinesListPage> {
  bool showInfo = false;
  Map<String, dynamic>? datos;
  String selectedCardId = "";

  @override
  Widget build(BuildContext context) {
    var VacunaBlock = context.watch<Vacunablock>();
    Provider.of<Vacunablock>(context);

    consultVaccine(String id_vac) async {
      var get = await VacunaBlock.getVacunar(id_vac);
      return get;
    }

    return FutureBuilder(
        future: Data.getVaccinesForPet(widget.pet.id_mascota),
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
                title: Text('Vacunas de ${widget.pet.name_masc}'),
              ),
          body: DynamicBackground(
              child: snapshot.data.isEmpty
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
                          FutureBuilder<List<Map<String, dynamic>>>(
                            future: Data.getDoctorForId(vaccine.id_doctor),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return const Text('Error al cargar el veterinario');
                              } else {
                                if (snapshot.data?.isEmpty ?? true) {
                                  return const Text('Veterinario no disponible');
                                }else {
                                  var nameDoctor = snapshot.data?[0]['name'];
                                  return Text('Veterinario: $nameDoctor');
                                }
                              }
                            },
                          ),
                          FutureBuilder<List<Map<String, dynamic>>>(
                            future: Data.getClinicaForId(vaccine.id_sede),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return const Text('Error al cargar la Sede');
                              } else {
                                if (snapshot.data?.isEmpty ?? true) {
                                  return const Text('Sede no disponible');
                                }else {
                                  var nameSede = snapshot.data?[0]['nombre_sede'];
                                  return Text('Sede: $nameSede');
                                }
                              }
                            },
                          ),
                          const SizedBox(height: 8.0),
                          Row(
                            children: [
                              ElevatedButton(onPressed: () async {
                                var datos = await consultVaccine(vaccine.id_vacuna);
                                setState(() {
                                  selectedCardId = vaccine.id_vacuna;
                                  this.datos = datos.cast<String, dynamic>();
                                  showInfo = !showInfo;
                                });
                              },
                                child: Text(showInfo && selectedCardId == vaccine.id_vacuna ? 'Ocultar datos' : 'Ver datos'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8.0),
                          if (showInfo && datos != null && selectedCardId == vaccine.id_vacuna)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Bloque: ${datos!['Bloque']}'),
                                //Text('Transaccion: ${datos!['Transaccion']}'),
                                Text('Contrato: ${datos!['Contrato']}'),
                              ],
                            ),
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