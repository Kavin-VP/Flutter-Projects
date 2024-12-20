import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meals_app/app_screens/categories_screen.dart';
import 'package:meals_app/app_screens/meals_screen.dart';
import 'package:meals_app/app_screens/tabs_screen.dart';
import 'package:meals_app/data/dummy_data.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 77, 34, 0),
  ),
  textTheme: GoogleFonts.latoTextTheme(),
);
void main() {
  runApp(const App());
}

class App extends StatelessWidget
{
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:theme,
      home:TabsScreen(),
    );
  }
}