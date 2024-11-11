import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_application/answer_button.dart';
import 'package:quiz_application/data/questions.dart';
class QuestionScreen extends StatefulWidget {
  const QuestionScreen(this.addChoosedAnswer,{super.key});
  final Function addChoosedAnswer;
  @override
  State<StatefulWidget> createState() {
    return _QuestionScreenState();
  }
}

class _QuestionScreenState extends State<QuestionScreen> {

  var currentQuestionIndex=0;
  void changeQuestionIndex(String answer)
  {
    widget.addChoosedAnswer(answer);
    setState(() {
      currentQuestionIndex++;
    });
  }
  @override
  Widget build(context) {
    var currentQuestion = questions[currentQuestionIndex];
    return  SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
           Text(
              currentQuestion.question,
              // style: GoogleFonts.lato(
              //   color: Colors.white,
              //   fontSize: 20.0,
              //   fontWeight: FontWeight.bold,
              // ),
              style: const TextStyle(
                color:Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            ...currentQuestion.getShuffledAnswers().map((item){
              return AnswerButton(item, 
                (){
                  changeQuestionIndex(item);
                });
            }),
                    ],
        ),
      ),
    );
  }
}
