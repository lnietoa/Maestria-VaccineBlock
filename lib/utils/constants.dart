import 'package:flutter/material.dart';

class AppConstants {
  // Colores
  static const Color primaryColor = Colors.green;
  static const Color secondaryColor = Colors.lightGreenAccent;
  static const Color headlineColor = Colors.green;
  static const Color bodyTextColor = Colors.black87;
  static const Color inputBorderColor = Colors.green;
  static const Color labelColor = Colors.green;
  static const Color buttonBackgroundColor = Colors.green;
  static const Color buttonForegroundColor = Colors.white;
  static const Color drawerHeaderColor = Colors.green;
  static const Color drawerHeaderTextColor = Colors.white;
  static const Color iconColor = Colors.green;
  static const Color textColor = Colors.black;

  // Nuevo estilo para el título del login
  static const TextStyle loginTitleStyle = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: Colors.green,
    shadows: [
      Shadow(
        blurRadius: 10.0,
        color: Colors.white,
        offset: Offset(2.0, 2.0),
      ),
    ],
  );

  // Text Styles
  static const TextStyle headlineLarge = TextStyle(
    fontSize: 32.0,
    fontWeight: FontWeight.bold,
    color: headlineColor,
    fontFamily: 'Roboto', // Cambiar a una fuente más comercial
  );
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16.0,
    color: bodyTextColor,
    fontFamily: 'Roboto', // Cambiar a una fuente más comercial
  );
  static const TextStyle buttonTextStyle = TextStyle(
    fontSize: 16.0,
    fontFamily: 'Roboto', // Cambiar a una fuente más comercial
  );
}