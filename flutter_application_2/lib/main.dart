import 'package:flutter/material.dart';
import 'dice_roller.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      backgroundColor: const Color.fromARGB(255, 36, 67, 121),
      //body: GradientContainer(Colors.grey, Colors.white),
      body: Center(
        child: DiceRoller(),
      ),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 236, 245, 136),
        title: Text('Dice Roller',
            style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold)),
      ),
    ),
  ));
}


// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Home Page'),
//         ),
//         body: Center(child: Builder(builder: (context) {
//           return Column(
//             children: [
//               Text('Hello World'),
//               SizedBox(
//                 height: 20,
//               ),
//               ElevatedButton(
//                   onPressed: () {
//                     print('button pressed');
//                   },
//                   child: Text('Button'))
//             ],
//           );
//         })),
//       ),
//     );
//   }
// }

//Here all classes are widgets
//material app, scaffold, appbar, text, 
//column, builder,elevated button, etc..
