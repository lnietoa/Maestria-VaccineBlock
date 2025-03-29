import 'package:mongo_dart/mongo_dart.dart';

class Doctor {
  final ObjectId id;
  final int id_doctor;
  final int id_sede;
  final int num_tp;
  final String name;
  final int contact;

  const Doctor({
    required this.id,
    required this.id_doctor,
    required this.id_sede,
    required this.num_tp,
    required this.name,
    required this.contact,
  });

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'id_doctor': id_doctor,
      'id_sede': id_sede,
      'num_tp': num_tp,
      'name': name,
      'contact': contact
    };
  }

  Doctor.fromMap(Map<String, dynamic> map)
      : id = map['_id'],
        id_doctor = map['id_doctor'],
        id_sede = map['id_sede'],
        num_tp = map['num_tp'],
        name = map['name'],
        contact = map['contact'];

}