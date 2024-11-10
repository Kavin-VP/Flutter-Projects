import 'package:flutter/material.dart';
import 'package:quiz_application/data/questions.dart';
import 'package:quiz_application/question_screen.dart';
import 'package:quiz_application/result_screen.dart';
import 'package:quiz_application/start_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<StatefulWidget> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  Widget?activeScreen;

  final List<String> choosedAnswers = [];
  @override
  void initState() {
    activeScreen = StartScreen(changeScreen);
    super.initState();
  }

  void changeScreen() {
    setState(() {
      activeScreen = QuestionScreen(addChoosedAnswer);
    });
  }

  void addChoosedAnswer(String answer)
  {
    choosedAnswers.add(answer);

    if(choosedAnswers.length==questions.length)
    {
      setState(() {
        activeScreen=ResultScreen(chosenAnswers: choosedAnswers);
      });

      //choosedAnswers.clear();
    }
    //print(choosedAnswers);
  }

  void retryQuiz()
  {
    setState(() {
      choosedAnswers.clear();
      activeScreen=QuestionScreen(addChoosedAnswer);
    });
  }
  @override
  Widget build(context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 21, 15, 92),
        body: activeScreen,
      ),
    );
  }
}
