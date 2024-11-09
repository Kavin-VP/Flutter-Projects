import 'dart:math';

import 'package:flutter/material.dart';

class DiceRoller extends StatefulWidget {
  @override
  State<DiceRoller> createState() {
    return _DiceRollerState();
  }
}

class _DiceRollerState extends State<DiceRoller> {
  var activeImage = 'assets/images/dice-1.png';
  var generatedNumber = 1;
  void rollDice() {
    setState(() {
      var randNumber = (Random().nextInt(6) + 1);
      generatedNumber = randNumber;
      print(randNumber);
      activeImage = 'assets/images/dice-$randNumber.png';
    });
    print('clicked button');
  }

  @override
  Widget build(context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(activeImage, width: 100),
        //SizedBox(height: 20,),
        TextButton(
            style: TextButton.styleFrom(
                padding: EdgeInsets.all(8),
                foregroundColor: Colors.white,
                backgroundColor: const Color.fromARGB(255, 53, 52, 52),
                textStyle: TextStyle(
                  fontSize: 15,
                )),
            onPressed: rollDice,
            child: Text('Roll Dice')),
        Text(
          'The number is $generatedNumber',
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
