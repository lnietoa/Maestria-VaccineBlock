import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../utils/locales.dart';
import '../widgets/dynamic_background.dart';
import '../components/menu.dart';
import '../data/data.dart';
import '../models/owner.dart';
import 'register_pet.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;


class RegisterOwnerPage extends StatefulWidget {
  const RegisterOwnerPage({super.key});

  @override
  State<RegisterOwnerPage> createState() => _RegisterOwnerPageState();
}

class _RegisterOwnerPageState extends State<RegisterOwnerPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  void _registerOwner() {
    final name = _nameController.text;
    final id = _idController.text;
    final address = _addressController.text;
    final phone = _phoneController.text;
    final email = _emailController.text;

    if (name.isNotEmpty && id.isNotEmpty && address.isNotEmpty && phone.isNotEmpty && email.isNotEmpty) {
      Data.addOwner(Owner(id: M.ObjectId(), name: name, identificacion: int.parse(id), address: address, phone: phone, email: email));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(RegisterOwnerStrings.ownerRegistered)),
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => RegisterPetPage(ownerId: id)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(RegisterOwnerStrings.allFieldsRequired)),
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
        title: const Text(RegisterOwnerStrings.registerOwner),
      ),
      drawer: const Menu(),
      body: DynamicBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Image.asset(
                  'assets/images/owners.png',
                  width: 225,
                  height: 225,
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
                          controller: _idController,
                          decoration: _inputDecoration(RegisterOwnerStrings.id),
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: _nameController,
                          decoration: _inputDecoration(RegisterOwnerStrings.name),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: _addressController,
                          decoration: _inputDecoration(RegisterOwnerStrings.address),
                        ),
                        const SizedBox(height: 30),
                        TextField(
                          controller: _phoneController,
                          decoration: _inputDecoration(RegisterOwnerStrings.phone),
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: _emailController,
                          decoration: _inputDecoration(RegisterOwnerStrings.email),
                        ),
                        const SizedBox(height: 30),
                        Tooltip(
                          message: RegisterOwnerStrings.ownerRegistered,
                          child: ElevatedButton(
                            onPressed: _registerOwner,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppConstants.buttonBackgroundColor,
                              foregroundColor: AppConstants.buttonForegroundColor,
                              textStyle: AppConstants.buttonTextStyle,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: const Text(RegisterOwnerStrings.register),
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