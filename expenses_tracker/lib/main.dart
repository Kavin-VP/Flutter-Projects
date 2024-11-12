import 'package:flutter/material.dart';
import 'package:expenses_tracker/widgets/expenses.dart';
//import 'package:flutter/services.dart';

var kColorScheme = ColorScheme.fromSeed(seedColor:const Color.fromARGB(255, 180, 188, 223));
void main() {

  //to lock the app's device orientation
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //   [
  //     DeviceOrientation.portraitUp,
  //     //DeviceOrientation.landscapeRight,
  //   ]
  // ).then((value){
  runApp(
     MaterialApp(
      theme: ThemeData().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 226, 227, 235),
        colorScheme: kColorScheme,
        cardTheme: const CardTheme().copyWith(
          color: const Color.fromARGB(255, 213, 215, 230),
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 6)
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.secondaryContainer
          )
        ),
        textTheme: ThemeData().textTheme.copyWith(
          titleLarge: const TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 21.0
          )
        ),
      ),
      home: const Expenses(),
    )
  );
  }
  //);

  

