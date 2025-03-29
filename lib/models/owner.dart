import 'package:mongo_dart/mongo_dart.dart';

class Owner {
  final ObjectId id;
  final int identificacion;
  final String name;
  final String address;
  final String phone;
  final String email;

  const Owner({
    required this.id,
    required this.name,
    required this.identificacion,
    required this.address,
    required this.phone,
    required this.email,
  });

  Map<String, dynamic> toMap(){
    return {
      '_id': id,
      'id_propietario': identificacion,
      'nombre_prop': name,
      'direccion': address,
      'telefono': phone,
      'correo': email
    };
  }

  Owner.fromMap(Map<String, dynamic> map)
  : id = map['_id'],
    identificacion = map['id_propietario'],
    name = map['nombre_prop'],
    address = map['direccion'],
    phone = map['telefono'],
    email = map['correo'];

}