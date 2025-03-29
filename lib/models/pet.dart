import 'package:mongo_dart/mongo_dart.dart';

class Pet {
  final ObjectId id;
  final String id_mascota;
  final String name_masc;
  final String species;
  final String race;
  final String sex;
  final String color;
  final String fecha_nac;

  const Pet({
    required this.id,
    required this.id_mascota,
    required this.name_masc,
    required this.species,
    required this.race,
    required this.sex,
    required this.color,
    required this.fecha_nac,
  });

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'id_mascota': id_mascota,
      'nombre_masc': name_masc,
      'especie': species,
      'raza': race,
      'sexo': sex,
      'color': color,
      'fecha_nac': fecha_nac
    };
  }

  Pet.fromMap(Map<String, dynamic> map)
     :  id = map['_id'],
        id_mascota = map['id_mascota'],
        name_masc = map['nombre_masc'],
        species = map['especie'],
        race = map['raza'],
        sex = map['sexo'],
        color = map['color'],
        fecha_nac = map['fecha_nac'];

//  void addVaccine(Vaccine vaccine) {
//    vaccines.add(vaccine);
//  }

}
