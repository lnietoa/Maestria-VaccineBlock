import 'package:mongo_dart/mongo_dart.dart';


class Vaccine {
  final ObjectId id;
  final String id_vacuna;
  final String id_mascota;
  final String name_vac;
  final String date_vac;
  final int id_doctor;
  final int id_sede;
  final String laboratorio;

  const Vaccine({
    required this.id,
    required this.id_vacuna,
    required this.id_mascota,
    required this.name_vac,
    required this.date_vac,
    required this.id_doctor,
    required this.id_sede,
    required this.laboratorio,
  });

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'id_vacuna': id_vacuna,
      'id_mascota': id_mascota,
      'nombre_vac': name_vac,
      'fecha_vac': date_vac,
      'id_doctor': id_doctor,
      'id_sede': id_sede,
      'laboratorio': laboratorio
    };
  }

  Vaccine.fromMap(Map<String, dynamic> map)
      :  id = map['_id'],
        id_vacuna = map['id_vacuna'],
        id_mascota = map['id_mascota'],
        name_vac = map['nombre_vac'],
        date_vac = map['fecha_vac'],
        id_doctor = map['id_doctor'],
        id_sede = map['id_sede'],
        laboratorio = map['laboratorio'];

}