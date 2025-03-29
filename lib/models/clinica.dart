import 'package:mongo_dart/mongo_dart.dart';

class Clinica {
  final ObjectId id;
  final int id_sede;
  final String nombre_sede;
  final String direccion_sede;
  final String telefono_sede;

  const Clinica({
    required this.id,
    required this.id_sede,
    required this.nombre_sede,
    required this.direccion_sede,
    required this.telefono_sede,
  });

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'id_sede': id_sede,
      'nombre_sede': nombre_sede,
      'direccion_sede': direccion_sede,
      'telefono_sede': telefono_sede
    };
  }

  Clinica.fromMap(Map<String, dynamic> map)
      : id = map['_id'],
        id_sede = map['id_sede'],
        nombre_sede = map['nombre_sede'],
        direccion_sede = map['direccion_sede'],
        telefono_sede = map['telefono_sede'];

}