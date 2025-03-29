import 'package:mongo_dart/mongo_dart.dart';
import '../models/doctor.dart';
import '../models/owner.dart';
import '../models/pet.dart';
import '../models/vaccine.dart';
import '../data/constants.dart';

class Data {

  static var bd, colleccionOwners, colleccionMascotas, colleccionVacunas;
  static var colleccionDoctores, colleccionClinica;

  static conectar() async {
    bd = await Db.create(Conexion);
    await bd.open();
    colleccionOwners = bd.collection(colleccion_propietarios);
    colleccionMascotas = bd.collection(colleccion_mascotas);
    colleccionVacunas = bd.collection(colleccion_vacunas);
    colleccionDoctores = bd.collection(colleccion_doctores);
    colleccionClinica = bd.collection(colleccion_clinica);
  }

  static Future<List<Map<String, dynamic>>> getOwners() async{
    try{
      final owners = await colleccionOwners.find().toList();
      return owners;
    } catch (e) {
      print(e);
      return Future.value();
    }

  }

  static Future<String> getOwnerById(int ownerId) async {
    final owner = await colleccionOwners.find(where.eq('id_propietario', ownerId)).toList();
    final ownerMap = Owner.fromMap(owner);
    return ownerMap.name;
  }

  static addOwner(Owner owner) async {
    await colleccionOwners.insertAll([owner.toMap()]);
  }

  static updateOwner(Owner owner) async {
    var o = await colleccionOwners.findOne({"id_propietario": owner.identificacion});
    o["nombre_prop"] = owner.name;
    o["direccion"] = owner.address;
    o["telefono"] = owner.phone;
    o["correo"] = owner.email;

    await colleccionOwners.save(o);
  }

  static deleteOwner(Owner owner) async {
    await colleccionOwners.remove(where.id(owner.id));
  }

  static Future<List<Map<String, dynamic>>> getPets() async{
    try{
      final pets = await colleccionMascotas.find().toList();
      return pets;
    } catch (e) {
      print(e);
      return Future.value();
    }
  }

  static addPet(Pet pet) async{
    await colleccionMascotas.insertAll([pet.toMap()]);
  }

  static Future<int> getPetCountForOwner(String ownerId) async {
      final count = await colleccionMascotas.count(where.match('id_mascota', ownerId));
      return count;
  }


  static Pet? getPetById(String petId) {
   return Pet(id: ObjectId(), id_mascota: '1', name_masc: '1', species: '1', race: '1', sex: '1', color: '1', fecha_nac: '1');
  }

  static addVaccineToPet(Vaccine vaccine) async {
    await colleccionVacunas.insertAll([vaccine.toMap()]);
  }

  static Future<List<Map<String, dynamic>>> getVaccinesForPet(String petId) async{
    try{
      final vaccines = await colleccionVacunas.find(where.eq('id_mascota', petId)).toList();
      return vaccines;
    } catch (e) {
      print(e);
      return Future.value();
    }
  }

  static addDoctor(Doctor doctor) async{
    await colleccionDoctores.insertAll([doctor.toMap()]);
  }

  static Future<List<Map<String, dynamic>>> getDoctors() async{
    try{
      final doctors = await colleccionDoctores.find().toList();
      return doctors;
    } catch (e) {
      print(e);
      return Future.value();
    }
  }

//  static generateDoctorId() {
//    return doctors.length.toString();
//  }

//  static List<Vaccine> getVaccinesForPet(String petId) {
//    final pet = getPetById(petId);
//    return [];
//  }
}