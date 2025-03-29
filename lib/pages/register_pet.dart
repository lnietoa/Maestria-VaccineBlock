import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../utils/locales.dart';
import '../widgets/dynamic_background.dart';
import '../components/menu.dart';
import '../data/data.dart';
import '../models/pet.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;


class RegisterPetPage extends StatefulWidget {
  final String? ownerId;

  const RegisterPetPage({super.key, this.ownerId});

  @override
  State<RegisterPetPage> createState() => _RegisterPetPageState();
}

class _RegisterPetPageState extends State<RegisterPetPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _specieController = TextEditingController();
  final TextEditingController _raceController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();
  final TextEditingController _sexController = TextEditingController();
  final TextEditingController _fechaController = TextEditingController();

  late String _generatedPetId;
  late String _ownerId;

  @override
  void initState() {
    super.initState();
    if (widget.ownerId != null) {
      _ownerId = widget.ownerId!;
      _generatePetId(_ownerId).then((String result){setState(() {
        _generatedPetId = result;
      });
      });
//      _generatedPetId = _generatePetId(_ownerId);
    }
  }

  Future<String> _generatePetId(String ownerId) async{
    int petCount = await Data.getPetCountForOwner(ownerId);
    final id = '$ownerId-${(petCount + 1).toString().padLeft(2, '0')}';
    return id;
  }

  void _registerPet() {

    final name_masc = _nameController.text;
    final species = _specieController.text;
    final race = _raceController.text;
    final color = _colorController.text;
    final sex = _sexController.text;
    final fecha_nac = _fechaController.text;

    if (name_masc.isNotEmpty && species.isNotEmpty && race.isNotEmpty && color.isNotEmpty
        && sex.isNotEmpty && fecha_nac.isNotEmpty) {
      Data.addPet(Pet(id: M.ObjectId(), id_mascota: _generatedPetId, name_masc: name_masc,
            race: race, species: species, sex: sex, color: color, fecha_nac: fecha_nac));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(RegisterPetStrings.petRegistered)),
      );
      FocusScope.of(context).unfocus(); // Hide the keyboard
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(RegisterPetStrings.allFieldsRequired)),
      );
    }
  }

  InputDecoration _inputDecoration(String label) {
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

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(RegisterPetStrings.registerPet),
      ),
      drawer: const Menu(),
      body: DynamicBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerRight,
                  child: Image.asset(
                    'assets/images/dogs.png',
                    width: 225,
                    height: 225,
                  ),
                ),
                const SizedBox(height: 5),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 8.0,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: <Widget>[
                        TextField(
                          controller: _nameController,
                          decoration: _inputDecoration(RegisterPetStrings.name),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: _specieController,
                          decoration: _inputDecoration(RegisterPetStrings.specie),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: _raceController,
                          decoration: _inputDecoration(RegisterPetStrings.race),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: _colorController,
                          decoration: _inputDecoration(RegisterPetStrings.color),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: _sexController,
                          decoration: _inputDecoration(RegisterPetStrings.sex),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: _fechaController,
                          decoration: _inputDecoration(RegisterPetStrings.fecha),
                        ),
                        const SizedBox(height: 16),
                        Tooltip(
                          message: RegisterPetStrings.petRegistered,
                          child: ElevatedButton(
                            onPressed: _registerPet,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppConstants.buttonBackgroundColor,
                              foregroundColor: AppConstants.buttonForegroundColor,
                              textStyle: AppConstants.buttonTextStyle,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: const Text(RegisterPetStrings.register),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}