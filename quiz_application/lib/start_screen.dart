import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen(this.startQuiz, {super.key});
  final Function startQuiz;

  @override
  Widget build(context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 21, 15, 92),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Opacity(
                opacity: 0.9,
                child: Image.asset(
                  'assets/images/quiz-logo.png',
                  width: 300,
                  //height: 300,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'Test Your Skills...!!!',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: OutlinedButton.icon(
                    onPressed: () {
                      startQuiz();
                    },
                    icon: const Icon(Icons.arrow_right_alt),
                    label: const Text(
                      'Start Quiz',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// void changeScreen()
// {
//   _QuizState()
// }