
import 'package:flutter/material.dart';
import '../data/data.dart';
import 'dashboard.dart';
import '../utils/constants.dart';
import '../utils/locales.dart';
import '../widgets/dynamic_background.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    if (username == 'admin' && password == 'admin') {
      await Data.conectar();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DashboardPage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login Failed')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DynamicBackground(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(40.0, 60.0, 20.0, 20.0),
                child: Image.asset(
                  'assets/images/banner2.png',
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      LoginStrings.loginTitle,
                      style: AppConstants.loginTitleStyle,
                    ),
                    const SizedBox(height: 25),
                    TextField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        labelText: LoginStrings.username,
                        labelStyle: TextStyle(color: AppConstants.labelColor),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppConstants.inputBorderColor),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        labelText: LoginStrings.password,
                        labelStyle: TextStyle(color: AppConstants.labelColor),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppConstants.inputBorderColor),
                        ),
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppConstants.buttonBackgroundColor,
                        foregroundColor: AppConstants.buttonForegroundColor,
                        textStyle: AppConstants.buttonTextStyle,
                      ),
                      child: const Text(LoginStrings.login),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
