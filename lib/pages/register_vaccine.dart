import 'package:blockchain_vaccine_project/data/VacunaBlock.dart';
import 'package:blockchain_vaccine_project/models/doctor.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../data/data.dart';
import '../models/pet.dart';
import '../models/vaccine.dart';
import '../utils/constants.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;

class RegisterVaccinePage extends StatelessWidget {
  final Pet pet;

  const RegisterVaccinePage({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final vaccineNameController = TextEditingController();
    final dateController = TextEditingController();
    final sedeController = TextEditingController();
    final laboratorioController = TextEditingController();
    String? selectedDoctorId;



    var VacunaBlock = context.watch<Vacunablock>();
    Provider.of<Vacunablock>(context);

    Future<void> selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
      );
      if (picked != null) {
        dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      }
    }

    void registerVaccine() async {
      final vaccineName = vaccineNameController.text;
      final date = dateController.text;
      final vet = selectedDoctorId;
      final sede = sedeController.text;
      final laboratorio = laboratorioController.text;
      if (vaccineName.isNotEmpty &&
          date.isNotEmpty &&
          vet != null &&
          sede.isNotEmpty &&
          laboratorio.isNotEmpty) {
        //var get = await VacunaBlock.getVacunar();
        var VacId = await VacunaBlock.RegistrarBlock(
            pet.id_mascota, sede, vet, vaccineName, date, laboratorio);

        final vaccine = Vaccine(
            id: M.ObjectId(),
            id_vacuna: VacId,
            id_mascota: pet.id_mascota,
            name_vac: vaccineName,
            date_vac: date,
            id_doctor: int.parse(vet),
            id_sede: int.parse(sede),
            laboratorio: laboratorio);

        Data.addVaccineToPet(vaccine);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Vacuna registrada')),
        );
        FocusScope.of(context).unfocus(); // Hide the keyboard
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Todos los campos son requeridos')),
        );
      }
    }

    InputDecoration inputDecoration(String label) {
      return InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: AppConstants.labelColor),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppConstants.inputBorderColor),
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppConstants.inputBorderColor),
          borderRadius: BorderRadius.circular(10.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(10.0),
        ),
      );
    }


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
                      "Lo sentimos. Error cargando veterinarios.",
                      style: Theme
                          .of(context)
                          .textTheme
                          .headlineMedium,
                    )));
          }
          return Scaffold(
            appBar: AppBar(
              title: const Text('Registrar Vacuna'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 8.0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('ID de la Mascota: ${pet.id_mascota}'),
                        const SizedBox(height: 10),
                        Text('Nombre de la Mascota: ${pet.name_masc}'),
                        const SizedBox(height: 30),
                        TextFormField(
                          controller: vaccineNameController,
                          decoration: inputDecoration('Nombre de la Vacuna'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor ingrese el nombre de la vacuna';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: laboratorioController,
                          decoration: inputDecoration('Laboratorio'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor ingrese el nombre del laboratorio de la vacuna';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () => selectDate(context),
                          child: AbsorbPointer(
                            child: TextFormField(
                              controller: dateController,
                              decoration: inputDecoration(
                                  'Fecha de Administración'),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor ingrese la fecha de administración';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        FutureBuilder<List<Map<String, dynamic>>>(
                          future: Data.getDoctors(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return const Text('Error al cargar los doctores');
                            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                              return const Text('No hay doctores disponibles');
                            } else {
                              final doctorItems = snapshot.data!.map((doctor) {
                                return DropdownMenuItem<String>(
                                  value: doctor['id'] as String,
                                  child: Text(doctor['name'] as String),
                                );
                              }).toList();
                              return DropdownButtonFormField<String>(
                                decoration: inputDecoration('Veterinario'),
                                value: selectedDoctorId,
                                items: doctorItems,
                                onChanged: (String? newValue) {
                                  selectedDoctorId = newValue;
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor seleccione un veterinario';
                                  }
                                  return null;
                                },
                              );
                            }
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: sedeController,
                          decoration: inputDecoration('Sede'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor ingrese el nombre de la sede clinica';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: registerVaccine,
                          child: const Text('Registrar'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
