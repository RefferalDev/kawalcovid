import 'package:flutter/material.dart';
import 'package:kawal_corona/screens/mainScreen.dart';

main() {
  runApp(MaterialApp(
    title: "Kawal Corona",
    theme: ThemeData(
      primaryColor: Color(0xffd64136),
      accentColor: Color(0xffd64136),
      cardTheme: CardTheme(
        color: Colors.white,
      ),
      colorScheme: ColorScheme.light().copyWith(surface: Colors.grey.shade100),
    ),
    home: MainScreen(),
  ));
}
