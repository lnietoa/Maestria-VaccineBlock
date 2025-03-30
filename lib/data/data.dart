import 'dart:io';

import 'package:mongo_dart/mongo_dart.dart';
import '../models/doctor.dart';
import '../models/owner.dart';
import '../models/pet.dart';
import '../models/vaccine.dart';
import '../data/constants.dart';

//class MyHttpOverrides extends HttpOverrides {
//  @override
//  HttpClient createHttpClient(SecurityContext? context) {
//    return super.createHttpClient(context)
//      ..findProxy = (uri) {
//        return "PROXY 8.8.8.8:53";
//      };
//  }
//}

class Data {

  static var bd, colleccionOwners, colleccionMascotas, colleccionVacunas;
  static var colleccionDoctores, colleccionClinica;

  static conectar() async {
//    HttpOverrides.global = MyHttpOverrides();
    bd = await Db.create(Conexion);
    await bd.open();
    colleccionOwners = bd.collection(colleccion_propietarios);
    colleccionMascotas = bd.collection(colleccion_mascotas);
    colleccionVacunas = bd.collection(colleccion_vacunas);
    colleccionDoctores = bd.collection(colleccion_doctores);
    colleccionClinica = bd.collection(colleccion_clinica);
  }

  static desconectar() async {
//    HttpOverrides.global = MyHttpOverrides();
    await bd.close();
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

  static Future<List<Map<String, dynamic>>> getDoctorForId(int doctorId) async{
    try{
      final doctor = await colleccionDoctores.find(where.eq('id_doctor', doctorId)).toList();
      return doctor;
    } catch (e) {
      print(e);
      return Future.value();
    }
  }

  static Future<List<Map<String, dynamic>>> getVaccines() async{
    try{
      final vaccineslist = await colleccionVacunas.find().toList();
      return vaccineslist;
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

  static Future<List<Map<String, dynamic>>> getClinica() async{
    try{
      final clinicas = await colleccionClinica.find().toList();
      return clinicas;
    } catch (e) {
      print(e);
      return Future.value();
    }
  }

  static Future<List<Map<String, dynamic>>> getClinicaForId(int sedeId) async{
    try{
      final sede = await colleccionClinica.find(where.eq('id_sede', sedeId)).toList();
      return sede;
    } catch (e) {
      print(e);
      return Future.value();
    }
  }

  static Future<List<Map<String, dynamic>>> getOwnerForId(String idOwner) async{
    try{
      final ownerId = int.parse(idOwner.substring(0, idOwner.indexOf('-')));
      final sede = await colleccionOwners.find(where.eq('id_propietario', ownerId)).toList();
      return sede;
    } catch (e) {
      print(e);
      return Future.value();
    }
  }

}